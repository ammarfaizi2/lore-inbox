Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbTIVLfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 07:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbTIVLfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 07:35:25 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:44225 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263113AbTIVLfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 07:35:22 -0400
Subject: Re: RH-9 boot hangs from floppy bootdisk
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Shash Chatterjee <sasvata@badfw.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <bkkvb0$so3$1@sea.gmane.org>
References: <bkkvb0$so3$1@sea.gmane.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064230425.8593.10.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Mon, 22 Sep 2003 12:33:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-21 at 20:48, Shash Chatterjee wrote:
> When booting from floppy, it loads the kernel/ramdisk from floppy, then 
> recognizes the HW and then hangs with the following message (at the 
> bottom).  Hitting any key causes a single "keyboard: unknown keysequence 
> 0e .." and then I have to hard-reset to recover.

Firstly try booting with the additional option "ide=nodma". That will
hopefully get you installed but slowly and able to update to a newer
kernel.

