Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbTEVFVC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 01:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTEVFVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 01:21:02 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:31730 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S262488AbTEVFVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 01:21:01 -0400
Subject: Re: 2.5.69 doesn't boot
From: Martin Schlemmer <azarah@gentoo.org>
To: Dima Brodsky <dima@cs.ubc.ca>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030522050427.GA9191@columbia.cs.ubc.ca>
References: <20030522050427.GA9191@columbia.cs.ubc.ca>
Content-Type: text/plain
Organization: 
Message-Id: <1053581280.6506.17.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 22 May 2003 07:28:00 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-22 at 07:04, Dima Brodsky wrote:
> Hi,
> 
> 2.5.69 won't boot on a:
> 
> PIII 650, 512 Ram, 440 BX chipset (Asus board)
> GeForce 256 vga
> D-Link DFE-538TX (RealTek RTL8139) network card
> Tekram DC395U/UW/F DC315/U V1.41, 2002-06-21 scsi card for scanner
> 
> compiled with
> 
> gcc 3.2.3
> glibc 2.3.2
> modutils 2.4.22
> 
> I get
> 
> Uncompressing Linux ...  Booting the kernel.
> 
> and then nothing.  Not sure what's wrong.
> 
> My config file is below, any and all help would be greatly appreciated.
> 

> #
> # Character devices
> #
> # CONFIG_VT is not set
>

Above is your problem.  You need to enable that as well as:

CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y


Regards,

-- 
Martin Schlemmer


