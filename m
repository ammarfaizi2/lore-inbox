Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265338AbTF1TGP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 15:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbTF1TGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 15:06:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41866
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265338AbTF1TGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 15:06:12 -0400
Subject: Re: 2.4.21-ac4 & cm9739 & SATA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Onur Kucuk <onur@kablonet.com.tr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EFCD206.2020501@kablonet.com.tr>
References: <3EFCD206.2020501@kablonet.com.tr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056827795.6295.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jun 2003 20:16:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    2.4.21-ac4 (and ac3) have the sound working with i810_audio, but 
> there is no mixer control for digital sound. Neither I can control the 
> digital sound with "main volume control" nor I can see the control of 
> digital sound on any mixer (aumix etc)

This is a codec limit. The harware doesn't deal with it. For most
situations it can be addressed. If someone wants to write a _fast_
integer volume scaling routine for 8 and 16bit data blocks then we can
teach the audio drivers to use it.


