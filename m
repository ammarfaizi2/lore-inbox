Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317478AbSFRQ2B>; Tue, 18 Jun 2002 12:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317481AbSFRQ2A>; Tue, 18 Jun 2002 12:28:00 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:22833 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S317478AbSFRQ17>; Tue, 18 Jun 2002 12:27:59 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F5110927E7AA0@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: VMM - freeing up swap space
Date: Tue, 18 Jun 2002 19:26:11 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Sure. Execute `swapoff -a`, followed by `swapon -a`. This is no joke.

Thanks. That really helped, let alone the fact that swapoff is a lengthy
operation (I can understand why), the resulting memory was even less than
the original RAM+swap size. I guess that happened because of memory
rearrangements when moving it up to RAM.
