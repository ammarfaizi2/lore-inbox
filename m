Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267589AbSLSKE3>; Thu, 19 Dec 2002 05:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267594AbSLSKE3>; Thu, 19 Dec 2002 05:04:29 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:16388 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267589AbSLSKE2>; Thu, 19 Dec 2002 05:04:28 -0500
Message-Id: <200212190951.gBJ9pCs28149@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "D.A.M. Revok" <marvin@synapse.net>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133  Promise ctrlr, or...
Date: Thu, 19 Dec 2002 12:40:22 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Andre Hedrick <andre@linux-ide.org>, Manish Lachwani <manish@Zambeel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.10.10212180241580.8350-100000@master.linux-ide.org> <200212181635.58164.marvin@synapse.net> <1040251122.26501.0.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1040251122.26501.0.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 December 2002 20:38, Alan Cox wrote:
> On Wed, 2002-12-18 at 21:35, D.A.M. Revok wrote:
> > So.  I /think/ that somehow the Promise controller isn't being
> > initialized properly by the Linux kernel, UNLESS the mobo's BIOS
> > inits it first?
>
> In some situations yes. The BIOS does stuff including fixups we mere
> mortals arent permitted to know about.

OTOH mere mortals are allowed to make full dump of PCI config ;)

"D.A.M. Revok" <marvin@synapse.net>, can you send lspci -vvvxxx
outputs when you boot with BIOS enabled and BIOS disabled?
--
vda
