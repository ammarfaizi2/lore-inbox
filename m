Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318844AbSIIUky>; Mon, 9 Sep 2002 16:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318869AbSIIUjb>; Mon, 9 Sep 2002 16:39:31 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:57583
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318844AbSIIUin>; Mon, 9 Sep 2002 16:38:43 -0400
Subject: Re: md multipath with disk missing ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steve Mickeler <steve@neptune.ca>
Cc: Oktay Akbal <oktay.akbal@s-tec.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209090948430.12095-100000@triton.neptune.on.ca>
References: <Pine.LNX.4.44.0209090948430.12095-100000@triton.neptune.on.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 09 Sep 2002 21:45:40 +0100
Message-Id: <1031604341.29718.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 14:50, Steve Mickeler wrote:
> 
> Oktay,
> 
> You should really be using devfs in a situation such as yours, where you
> need device name consistency during reboots.
> 

There are a collection of nice tools that will run at boot up (eg from
initrd or from the rootfs mount) and generate a set of sun like /dev/
symlinks to the real scsi device by lun.

You don't need to play with experimental stuff like devfs

