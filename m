Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVE3Ngo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVE3Ngo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 09:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVE3Ngn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 09:36:43 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:50105 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261573AbVE3Nfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 09:35:53 -0400
Message-ID: <429B0003.5060803@yahoo.com.au>
Date: Mon, 30 May 2005 21:58:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: kus Kusche Klaus <kus@keba.com>, James Bruce <bruce@andrew.cmu.edu>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505301306510.12471-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10505301306510.12471-100000@da410.phys.au.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Nielsen wrote:

> I do like the idea of guest kernels - especially the ability to enforce a
> strict seperation of RT and non-RT. But you can't use _any_ part of the
> Linux kernel in your RT application - not even drivers. I know a lot of

If you can't use the drivers, then presumably they're no good
to be used as they are for realtime in Linux either, though :(

In which case, you may still be better off porting the driver
over and rewriting it to be hard-realtime than rewriting Linux
itself ;)

But I could be wrong. I don't pretend to have the answers (just
questions!).

Thanks,
Nick

Send instant messages to your online friends http://au.messenger.yahoo.com 
