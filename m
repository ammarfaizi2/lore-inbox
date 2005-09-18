Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbVIRHuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVIRHuM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 03:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVIRHuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 03:50:12 -0400
Received: from mx2.palmsource.com ([12.7.175.14]:54240 "EHLO
	mx2.palmsource.com") by vger.kernel.org with ESMTP id S1751324AbVIRHuL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 03:50:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Why don't we separate menuconfig from the kernel?
Date: Sun, 18 Sep 2005 00:50:10 -0700
Message-ID: <DE88BDF02F4319469812588C7950A97E93121F@ussunex1.palmsource.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why don't we separate menuconfig from the kernel?
Thread-Index: AcW8IrdMOtmdoj4VQDyUXoHVL1rL1wAApuiA
From: "Martin Fouts" <Martin.Fouts@palmsource.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: <jesper.juhl@gmail.com>, "Krzysztof Halasa" <khc@pm.waw.pl>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I'm a bit confused.
> Do you want to take a copy of kbuild or kconfig?
> 
> kbuild is much more intiminate than kconfig althougth the 
> latter has a few kernel only issues too.

Kconfig is nice without kbuild, but if you want to automate it in a
makefile, you'll want the bits of kbuild from the top level makefile
that do that.

So I guess my personal answer is I want kconfig with just enough kbuild
to make it nice.
