Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVCNGse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVCNGse (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 01:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVCNGsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 01:48:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:47011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261202AbVCNGsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 01:48:31 -0500
Date: Sun, 13 Mar 2005 22:48:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg Stark <gsstark@mit.edu>
Cc: gsstark@mit.edu, s0348365@sms.ed.ac.uk, linux-kernel@vger.kernel.org,
       pmcfarland@downeast.net
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
Message-Id: <20050313224805.3d75a06c.akpm@osdl.org>
In-Reply-To: <87r7ii6944.fsf@stark.xeocode.com>
References: <87u0ng90mo.fsf@stark.xeocode.com>
	<200503130152.52342.pmcfarland@downeast.net>
	<874qff89ob.fsf@stark.xeocode.com>
	<200503140103.55354.s0348365@sms.ed.ac.uk>
	<87sm2y7uon.fsf@stark.xeocode.com>
	<20050313200753.20411bdb.akpm@osdl.org>
	<87br9m7s8h.fsf@stark.xeocode.com>
	<87zmx66b2b.fsf@stark.xeocode.com>
	<20050313215710.5fa920d4.akpm@osdl.org>
	<87r7ii6944.fsf@stark.xeocode.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark <gsstark@mit.edu> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > The 2.6.6 i810_audio.c compiles OK in current kernels with the below patch
> > applied.  
> 
> This would be a good time to learn the right way to do this: how do I build a
> driver from a kernel tree without building the whole tree?

I don't think that's well supported for drivers which are already in-tree.

> Like, if I copy the 2.6.6 drivers to a new directory outside a kernel tree, is
> there some magic make command I can give it to point it at the 2.6.10 tree for
> the build environment including make includes and header files?

Suggest you simply copy the file into a 2.6.11 tree.
