Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWC2MC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWC2MC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 07:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWC2MC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 07:02:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:22467 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750846AbWC2MC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 07:02:28 -0500
Date: Wed, 29 Mar 2006 14:02:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Who wants to test cracklinux??
In-Reply-To: <yw1x8xquruy0.fsf@agrajag.inprovide.com>
Message-ID: <Pine.LNX.4.61.0603291401010.32036@yvahk01.tjqt.qr>
References: <20060328221223.80753cab.letterdrop@gmx.de> <20060328224929.GC5760@elf.ucw.cz>
 <yw1x8xquruy0.fsf@agrajag.inprovide.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> read/write on /dev/mem. chmod 666 /dev/mem if you want to allow normal
>> users to access physical memory (security hole, again).
>
>It's a security risk, but one that you might sometimes take to gain
>some performance on a non-critical machine.  I've done this in the
>past to be able to play videos smoothly on a slow machine.
>
Actually, not only you. MPlayer's vesa output module (IIRC. if not, 
then it was svga) pokes /dev/mem as well.
(Seeing vidix in your mail makes me assume you know the vesa/mem thing 
already. ;-)


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
