Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbWG2PQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWG2PQf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 11:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbWG2PQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 11:16:35 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:48356 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751649AbWG2PQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 11:16:35 -0400
Date: Sat, 29 Jul 2006 17:14:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: ProfiHost - Stefan Priebe <s.priebe@profihost.com>
cc: Nathan Scott <nathans@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: XFS / Quota Bug in  2.6.17.x and 2.6.18x
In-Reply-To: <44CB1D07.8010104@profihost.com>
Message-ID: <Pine.LNX.4.61.0607291714070.24901@yvahk01.tjqt.qr>
References: <44C8A5F1.7060604@profihost.com> <Pine.LNX.4.61.0607281909080.4972@yvahk01.tjqt.qr>
 <20060729075054.B2222647@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.61.0607290953480.20234@yvahk01.tjqt.qr> <44CB158B.1050209@profihost.com>
 <Pine.LNX.4.61.0607291001370.20234@yvahk01.tjqt.qr> <44CB1D07.8010104@profihost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1.) You need a Kernel, where barriers are on by default:
> so something like: 2.6.16.2x or 2.6.17.x
> I'm not shure of the minimal version for the 2.6.16.x Kernel tree.

2.6.17.6

> 3.) you boot your system with kernel option rootflags=quota

Ah I think there it is. I do boot with rootflags=, but since the initrd 
does the interpreting of rootflags= and mounting of /dev/hda2(/), that 
should pose a different situation?


Jan Engelhardt
-- 
