Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbUCLSa3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 13:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbUCLSa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 13:30:28 -0500
Received: from main.gmane.org ([80.91.224.249]:59296 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262365AbUCLSaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 13:30:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Jones <adam@yggdrasl.demon.co.uk>
Subject: Re: NVIDIA and 2.6.4?
Date: Fri, 12 Mar 2004 18:24:01 +0000
Organization: none
Message-ID: <adam.20040312182401$5015%samael.haus@yggdrasl.demon.co.uk>
References: <405082A2.5040304@blueyonder.co.uk> <200403111326.08055.maxvalde@fis.unam.mx> <405112DD.2020009@blueyonder.co.uk>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: yggdrasl.demon.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a futile gesture against entropy, Sid Boyce wrote:
> Max Valdez wrote:

> >Been using nvidia modules for quite a few 2.6.x kernels, most of them mmX. 
> >without problems

I'm using it here with 2.6.4, no problems as yet.

> Something strange happened, I shall try 2.6.4-mm1 shortly to see if it 
> is still the same. I reckon though that I've suffered a filesystem 
> corruption.

A quick thought - have you got CONFIG_REGPARM enabled in the kernel
config?  If so, disable it and try again.  (It's almost certain to
cause crashes with binary modules.)
-- 
Adam Jones (adam@yggdrasl.demon.co.uk)(http://www.yggdrasl.demon.co.uk/)
.oO("Hizbollah Central Press Office"                                   )
PGP public key: http://www.yggdrasl.demon.co.uk/pubkey.asc

