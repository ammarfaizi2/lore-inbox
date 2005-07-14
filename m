Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263116AbVGNTue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbVGNTue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbVGNTu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:50:27 -0400
Received: from smtp-4.llnl.gov ([128.115.41.84]:44688 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S261707AbVGNTtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:49:39 -0400
Date: Thu, 14 Jul 2005 12:49:37 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
In-reply-to: <200507141450.42837.annabellesgarden@yahoo.de>
To: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.63.0507141049410.9398@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <200507061257.36738.s0348365@sms.ed.ac.uk>
 <20050713103930.GA16776@elte.hu> <42D51EAF.2070603@cybsft.com>
 <200507141450.42837.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2005, Karsten Wiese wrote:

> Have I corrected the other path of ioapic early initialization, which had lacked
> virtual-address setup before ioapic_data[ioapic] was to be filled in -51-28?
> Please test attached patch on top of -51-29 or later.
> Also on Systems that liked -51-28.
>
>    thanks, Karsten
>

I applied your patch on top of -51-30 and all is well. I am applied it on top 
of -51-29 just for the heck of it and it's working well too, FWIW.

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
------------------ http://tinyurl.com/5w5ey -----------------------
-- Too bad stupidity isn't painful. --
