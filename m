Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280657AbRKJNoj>; Sat, 10 Nov 2001 08:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280658AbRKJNoV>; Sat, 10 Nov 2001 08:44:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62991 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280656AbRKJNoK>; Sat, 10 Nov 2001 08:44:10 -0500
Subject: Re: Any lingering Athlon bugs in Kernel 2.4.14?
To: calin@ajvar.org (Calin A. Culianu)
Date: Sat, 10 Nov 2001 13:51:36 +0000 (GMT)
Cc: rml@tech9.net (Robert Love), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111091843180.17281-100000@rtlab.med.cornell.edu> from "Calin A. Culianu" at Nov 09, 2001 06:45:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E162YXo-0006P8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> really think 2.4.13-ac7 has some cool hw bug workarounds? I guess I should
> read about what went into -ac7.... Where would be a good place to find
> more info?

If you want to be predictable about your test set then you can simply pull
the VIA Athlon workaround pci quirk form 2.4.13-ac or 2.4.14 and merge it
with your base 2.4.2, or 2.4.2-rh whatever tree.

In fact you can do it in userspace with setpci if thats politically optimal
8)


Alan
