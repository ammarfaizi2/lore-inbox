Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUCJICQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 03:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUCJICQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 03:02:16 -0500
Received: from emn-agsl-4744.mxs.adsl.euronet.nl ([212.129.199.68]:44561 "EHLO
	kapteyn.telox.net") by vger.kernel.org with ESMTP id S262134AbUCJICM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 03:02:12 -0500
Date: Wed, 10 Mar 2004 08:52:12 +0100
From: Wouter Lueks <wouter@telox.net>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
Message-ID: <20040310075211.GA8375@telox.net>
References: <16457.26208.980359.82768@napali.hpl.hp.com> <4049FE57.2060809@pacbell.net> <20040308061802.GA25960@cup.hp.com> <16460.49761.482020.911821@napali.hpl.hp.com> <404CEA36.2000903@pacbell.net> <16461.35657.188807.501072@napali.hpl.hp.com> <404E00B5.5060603@pacbell.net> <16462.1463.686711.622754@napali.hpl.hp.com> <404E2B98.6080901@pacbell.net> <16462.48341.393442.583311@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16462.48341.393442.583311@napali.hpl.hp.com>
X-Operating-System: Linux kapteyn 2.6.3 #1 Sat Mar 6 10:06:04 CET 2004 i686 GNU/Linux
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 10:59:33PM -0800, David Mosberger wrote:
> The current OHCI relies on the internals of the dma_pool()
> implementation.  If the implementation changed to, say, modify the
> memory that is free or, heaven forbid, return the memory to the
> kernel, you'd get _extremely_ difficult to track down race conditions.
> Even so, the code isn't race-free, like I explained yesterday:

I'm doing my best to track this thread altough I cannot understand the
technical stuff I belive you are havily tracking down a bug in the
ohci-hcd, but, according to the problems I expierienced, there is a 
similar bug in uhci-hcd.

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 04) (prog-if 00 [UHCI])
    Subsystem: NEC Corporation: Unknown device 815e
    Flags: bus master, medium devsel, latency 0, IRQ 9
    I/O ports at 1cc0 [size=32]

When there is any further information you need, or any extra testing
that needs to be done, please tell me and I'll be happy to help out. 

Keep up the good work!

Wouter Lueks
