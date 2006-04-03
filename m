Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751691AbWDCJUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWDCJUb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 05:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWDCJUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 05:20:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:56743 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751688AbWDCJUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 05:20:30 -0400
Date: Mon, 3 Apr 2006 11:20:07 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Phillip Susi <psusi@cfl.rr.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       beware <wimille@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Float numbers in module programming
In-Reply-To: <4430C6E5.20101@aitel.hist.no>
Message-ID: <Pine.LNX.4.61.0604031119330.2220@yvahk01.tjqt.qr>
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com>
 <Pine.LNX.4.61.0603290955440.27913@chaos.analogic.com>
 <Pine.LNX.4.61.0603301010400.30783@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com> <442C1415.6080906@cfl.rr.com>
 <4430C6E5.20101@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> To further complicate this:  Your driver can save the FPU registers,
> but it too may get interrupted. Possibly even by another instance of
> itself, if the user have several devices.
>
In which case the drive author probably already uses interrupt disabling.


Jan Engelhardt
-- 
