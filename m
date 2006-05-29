Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWE2R1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWE2R1G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 13:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWE2R1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 13:27:05 -0400
Received: from [129.97.134.17] ([129.97.134.17]:41099 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750725AbWE2R1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 13:27:05 -0400
Date: Mon, 29 May 2006 13:26:05 -0400
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Asus K8N-VM Motherboard Ethernet Problem
Message-ID: <20060529172605.GC18890@csclub.uwaterloo.ca>
References: <44793100.50707@perkel.com> <200605281920.02609.s0348365@sms.ed.ac.uk> <20060529141447.GA18892@csclub.uwaterloo.ca> <200605291746.01736.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605291746.01736.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 05:46:01PM +0100, Alistair John Strachan wrote:
> Since this document reveals no information about such a MAC device, it is 
> still unknown whether forcedeth is truly to blame. From the silence of the 
> original poster I'm inclined to assume he's fixed the problem..

Well the web page for the mainboard does say Integrated 10/100 Mb MAC,
which would be part of the nvidia chipset.  Being 100Mbit certainly
means it should work with forcedeth.  At least if the kernel is new
enough to recognize the chipset.

> I was suspicious because in contra to the original post, it is NOT the case 
> that Windows XP (even SP2) will automatically detect and support NVIDIA 
> ethernet; a third party driver must be installed before the device is usable. 
> Realtek chips, however, tend to work out of the box..

Well I don't know if XP added support for nvidia's network feature in
any of the service packs.  I do know it works with forcedeth on all the
nvidia boards I haved used, although I have only used their 100Mbit
versions.  There seemed to be a problem with 2.6.8 on some boards where
the nvidia MAC would not be detected, but manually loading forcedeth
worked anyhow.  Later kernels seemed to have no such problem.

Len Sorensen
