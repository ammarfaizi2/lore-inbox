Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261332AbSJYJhB>; Fri, 25 Oct 2002 05:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSJYJhB>; Fri, 25 Oct 2002 05:37:01 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:40901 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261332AbSJYJhA>; Fri, 25 Oct 2002 05:37:00 -0400
Subject: Re: PCI device order problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021024165631.A22676@lucon.org>
References: <20021024163945.A21961@lucon.org> <3DB88715.7070203@pobox.com> 
	<20021024165631.A22676@lucon.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 11:00:31 +0100
Message-Id: <1035540031.13032.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 00:56, H. J. Lu wrote:
> It is different from the hardware documentation. The hardware manual says
> it has 2 NICs, NIC 1 (03:07.0) and NIC2 (03:07.1), which makes senses
> to me. NIC 1 is a special one which supports IPMI over LAN. Since we
> only use one NIC now, we'd like to use NIC 1 and call it eth0.

SIOCSIFNAME ioctl. You can call them "haddock" and "chips" if you really
want, or swap the eth%d names about. RH 8.0 allows you to bind an
interface to a mac address too

