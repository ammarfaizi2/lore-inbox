Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSKDShZ>; Mon, 4 Nov 2002 13:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262512AbSKDShZ>; Mon, 4 Nov 2002 13:37:25 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:40593 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262457AbSKDShY>; Mon, 4 Nov 2002 13:37:24 -0500
Subject: RE: Patch: 2.5.45 PCI Fixups for PCI HotPlug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: jung-ik.lee@intel.com, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211041823.KAA09629@adam.yggdrasil.com>
References: <200211041823.KAA09629@adam.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 19:05:39 +0000
Message-Id: <1036436739.2040.111.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 18:23, Adam J. Richter wrote:
> 	There is no reason to use __pci_devinit for chipsets that are
> only soldered into motherboards.  I believe there are only a few of
> those quirk handlers that CONFIG_PCI_HOTPLUG users really need to
> retain in their kernels.

You might be suprised what "motherboard" chips turn up in docking
stations.My TP600 for example has an IBM southbridge in it.

