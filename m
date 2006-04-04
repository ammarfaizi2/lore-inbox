Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWDDN2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWDDN2p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 09:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWDDN2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 09:28:44 -0400
Received: from [212.33.180.135] ([212.33.180.135]:61456 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932413AbWDDN2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 09:28:42 -0400
From: Al Boldi <a1426z@gawab.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Date: Tue, 4 Apr 2006 16:27:25 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200604031459.51542.a1426z@gawab.com> <4431A9E7.40406@bigpond.net.au>
In-Reply-To: <4431A9E7.40406@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604041627.25359.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Al Boldi wrote:
> >>>> Control parameters for the scheduler can be read/set via files in:
> >>>>
> >>>> /sys/cpusched/<scheduler>/
> >
> > The default values for spa make it really easy to lock up the system.
>
> Which one of the SPA schedulers and under what conditions?  I've been
> mucking around with these and may have broken something.  If so I'd like
> to fix it.

spa_no_frills, with a malloc-hog less than timeslice.  Setting 
promotion_floor to max unlocks the console.

Thanks!

--
Al

