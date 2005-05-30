Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVE3Thv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVE3Thv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVE3Thm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:37:42 -0400
Received: from opersys.com ([64.40.108.71]:15118 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261726AbVE3TgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:36:08 -0400
Message-ID: <429B6D89.3090705@opersys.com>
Date: Mon, 30 May 2005 15:46:17 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, kus Kusche Klaus <kus@keba.com>,
       James Bruce <bruce@andrew.cmu.edu>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505302125520.31148-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10505302125520.31148-100000@da410.phys.au.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Esben Nielsen wrote:
> But if you do have to maintain your own driver it is a lot easier to start
> from an existing and fix that one than it is to start all over. I bet the
> modifcations aren't too big for many drivers anyways. When I get more time
> I'll try to look into some drivers. Many of them is propably just about
> removing printk's and the like.

Right, and that's exactly what you've got with RT-net (at least the last
time I used it 4 years ago.) You took the standard Ethernet driver from
Linux and modified a few calls, and bingo, you had an rt-net driver based
on the standard Linux driver ... all of which in RTAI ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
