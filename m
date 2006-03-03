Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWCCNdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWCCNdq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 08:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWCCNdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 08:33:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:43149 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751436AbWCCNdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 08:33:45 -0500
Date: Fri, 3 Mar 2006 14:33:44 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: roland <devzero@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: is there a COW inside the kernel ?
In-Reply-To: <043101c63e9c$86e9d710$0200000a@aldipc>
Message-ID: <Pine.LNX.4.61.0603031432530.2581@yvahk01.tjqt.qr>
References: <043101c63e9c$86e9d710$0200000a@aldipc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is there an equivalent of something like
> cowloop ( http://www.atconsultancy.nl/cowloop/total.html ) or md based cow
> device ( http://www.cl.cam.ac.uk/users/br260/doc/report.pdf ),
> i.e. a feature called "Copy On Write Blockdevice" inside the current or the
> near-future mainline kernel (besides UserModeLinux Arch)?

Not directly block-device-based cow, but unionfs is at least a 
filesystem-based cow.


Jan Engelhardt
-- 
