Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267573AbTA3Rn0>; Thu, 30 Jan 2003 12:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbTA3Rn0>; Thu, 30 Jan 2003 12:43:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27528
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267573AbTA3RnZ>; Thu, 30 Jan 2003 12:43:25 -0500
Subject: Re: [PATCH] USB HardDisk Booting 2.4.20
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wesley Wright <wewright@verizonmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1043947657.7725.32.camel@steven>
References: <1043947657.7725.32.camel@steven>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043952432.31674.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 30 Jan 2003 18:47:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-30 at 17:27, Wesley Wright wrote:
> My tests show that it seems to work, and I haven't noticed any odd side
> affects by initcall-ing the usb devices (concern over this topic is why
> I enabled it for static USB MSD only).
> 
> Does this seem a reasonable solution, or does anyone have something more
> elegant?

Is there a reason for not using initrd for this. That should let you
use any kind of root device even ones requiring user space work before
the real root is mounted.

