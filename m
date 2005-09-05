Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVIEP6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVIEP6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 11:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVIEP6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 11:58:22 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:22720 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S932225AbVIEP6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 11:58:22 -0400
To: gl@dsa-ac.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: who sets boot_params[].screen_info.orig_video_isVGA?
In-Reply-To: <Pine.LNX.4.63.0509051736420.11341@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0509051646480.11341@pcgl.dsa-ac.de> <E1ECIub-00088O-00@chiark.greenend.org.uk> <E1ECIub-00088O-00@chiark.greenend.org.uk> <Pine.LNX.4.63.0509051736420.11341@pcgl.dsa-ac.de>
Date: Mon, 5 Sep 2005 16:58:21 +0100
Message-Id: <E1ECJMT-0004Zp-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gl@dsa-ac.de <gl@dsa-ac.de> wrote:

> Do I get it right, that, say, if I tell grub to load a kernel and specify 
> "vga=xxx" on the kernel command line, grub will interpret it, issue some 
> VESA BIOS calls and fill in the screen_info struct? If so, the card often 
> supports several modes (VGA, SVGA, VESA, different resolutions, colour 
> depths, etc.), right? So, which one will be chosen? Does it depend on the 
> specific value I give to "vga="? How do I force VIDEO_TYPE_VLFB (VESA VGA 
> in graphic mode) mopde then?

Yup. You probably want to take a look at Documentation/fb/vesafb.txt -
the modes are the same.
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
