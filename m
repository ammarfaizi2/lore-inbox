Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290228AbSBSVNp>; Tue, 19 Feb 2002 16:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290229AbSBSVN2>; Tue, 19 Feb 2002 16:13:28 -0500
Received: from hermes.toad.net ([162.33.130.251]:37776 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S290218AbSBSVNK>;
	Tue, 19 Feb 2002 16:13:10 -0500
Subject: Re: 2.5.4 PNPBIOS fault
From: Thomas Hood <jdthood@mail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0202191042380.1465-100000@dragon.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33L2.0202191042380.1465-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 19 Feb 2002 16:13:29 -0500
Message-Id: <1014153212.5039.145.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-19 at 13:48, Randy.Dunlap wrote:
> 
> Linux 2.5.4 with PNPBIOS support enabled:
> 
> Looks like a PnP BIOS fault to me (i.e., in the system
> BIOS, not the kernel).

Test by booting with "pnpbios=off".

Alan Cox has modified the driver recently so that
the kpnpbios kernel thread starts later than it
does now.  Perhaps that change will help you.

