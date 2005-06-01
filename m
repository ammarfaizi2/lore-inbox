Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVFAA25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVFAA25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 20:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVFAA25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 20:28:57 -0400
Received: from opersys.com ([64.40.108.71]:56072 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261219AbVFAA24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 20:28:56 -0400
Message-ID: <429D0392.1040202@opersys.com>
Date: Tue, 31 May 2005 20:38:42 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Esben Nielsen <simlo@phys.au.dk>, Nick Piggin <nickpiggin@yahoo.com.au>,
       kus Kusche Klaus <kus@keba.com>, James Bruce <bruce@andrew.cmu.edu>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505302125520.31148-100000@da410.phys.au.dk> <429B70F2.20602@opersys.com> <20050531220151.GA1804@nietzsche.lynx.com>
In-Reply-To: <20050531220151.GA1804@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Huey (hui) wrote:
> This is really interesting code. It's really not unlike what preempt RT
> is already doing with the atomic locking (replacement). From the looks
> of it conversion of an ethernet driver to be RT capable is shockingly
> trivial.

It is. In some cases you need to provide alternate functions, but in
most not ... However, note that this is for UDP. There is no such
thing as deterministic TCP.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
