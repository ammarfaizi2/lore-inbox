Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbTFJV2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTFJV2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:28:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48295
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263983AbTFJV1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 17:27:19 -0400
Subject: Re: PROBLEM: Kernel Panic Promise driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sydow@speakeasy.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306101221370.1648-100000@web0.speakeasy.net>
References: <Pine.LNX.4.44.0306101221370.1648-100000@web0.speakeasy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055281115.32661.37.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jun 2003 22:38:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-10 at 20:39, sydow@speakeasy.net wrote:
> No current OS installed as this was from a boot disk to install.
> This is in a Tyan S2462 THunder K7 board, with dual Athlon 1.2Mhz MPs and 
> 1GB of memory. I have removed the Promise PDC support and added i2o and 
> the kernel boots fine. Expected behavior would be to use or have this 
> promise support in kernel and not to have it panic the kernel by trying to 
> initialize the SX6000 with the software raid drivers. This is a rare 
> (expensive) peice of hardware so you can contact me for testing if need be.

The promise driver should spot the i960 bridge and skip the 20265/7's on
the card. It works for the older supertrak 100 but I don't have an
SX6000. 

Can you send me an lspci -v and an lspci -vxx and we'll figure this one
out


