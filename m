Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266980AbSKQX0x>; Sun, 17 Nov 2002 18:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbSKQX0w>; Sun, 17 Nov 2002 18:26:52 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:55218 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266980AbSKQX0w>; Sun, 17 Nov 2002 18:26:52 -0500
Subject: Re: Reserving "special" port numbers in the kernel ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arun Sharma <arun.sharma@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <uu1ig9mps.fsf@unix-os.sc.intel.com>
References: <uel9mbcyi.fsf@unix-os.sc.intel.com>
	<1037414638.21937.20.camel@irongate.swansea.linux.org.uk> 
	<uu1ig9mps.fsf@unix-os.sc.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Nov 2002 22:59:11 +0000
Message-Id: <1037573951.5356.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-17 at 16:37, Arun Sharma wrote:
> The thing that's unique about our situation is that the daemon in not
> user level. It runs at hardware/firmware level, so that you can
> remotely administer the machine even when software is malfunctioning.

So you've got an administration port that ignores the firewall
facilities on the machine. Now tell me why anyone would buy such a
product ? What if your firmware has a network layer bug, what if someone
finds a security hole in it ?

If you want to steal ports from under the OS then you need your own IP
address and full network stack, not the one assigned to the Linux
system. 

Alan

