Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbSJYQEy>; Fri, 25 Oct 2002 12:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261461AbSJYQEy>; Fri, 25 Oct 2002 12:04:54 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:11971 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S261460AbSJYQEx>; Fri, 25 Oct 2002 12:04:53 -0400
Date: Fri, 25 Oct 2002 09:11:02 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI device order problem
Message-ID: <20021025091102.A15082@lucon.org>
References: <20021024163945.A21961@lucon.org> <3DB88715.7070203@pobox.com> <20021024165631.A22676@lucon.org> <1035540031.13032.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035540031.13032.3.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Oct 25, 2002 at 11:00:31AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 11:00:31AM +0100, Alan Cox wrote:
> On Fri, 2002-10-25 at 00:56, H. J. Lu wrote:
> > It is different from the hardware documentation. The hardware manual says
> > it has 2 NICs, NIC 1 (03:07.0) and NIC2 (03:07.1), which makes senses
> > to me. NIC 1 is a special one which supports IPMI over LAN. Since we
> > only use one NIC now, we'd like to use NIC 1 and call it eth0.
> 
> SIOCSIFNAME ioctl. You can call them "haddock" and "chips" if you really
> want, or swap the eth%d names about. RH 8.0 allows you to bind an
> interface to a mac address too
> 

It doesn't help RedHat installer over network.


H.J.
