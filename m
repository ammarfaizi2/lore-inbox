Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVCGAS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVCGAS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVCGARW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:17:22 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:1426 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261602AbVCFX7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 18:59:52 -0500
Date: Sun, 6 Mar 2005 15:59:41 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Darren Williams <dsw@gelato.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Page fault scalability patch V18: Overview
In-Reply-To: <20050306214902.GC19053@cse.unsw.EDU.AU>
Message-ID: <Pine.LNX.4.58.0503061557220.3152@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
 <20050304021847.GF28102@cse.unsw.EDU.AU> <20050304024704.GG28102@cse.unsw.EDU.AU>
 <Pine.LNX.4.58.0503040814220.17378@schroedinger.engr.sgi.com>
 <20050306214902.GC19053@cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2005, Darren Williams wrote:

> Hi Christoph
>
> On Fri, 04 Mar 2005, Christoph Lameter wrote:
>
> > Make sure that scrubd_stop on startup is set to 2 and no zero in
> > mm/scrubd.c. The current patch on oss.sgi.com may have that set to zero.
> >
> unsigned int sysctl_scrub_stop = 2;     /* Mininum order of page to zero */
>
> This is the assignment when page zero fails.

Could you just test this with the prezeroing patches alone?
Include a dmesg from a successful boot and then tell me what
you changed and where the boot failed. Which version of the patches did
you apply?

