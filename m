Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbTFMIOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbTFMIOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:14:10 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62895
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265125AbTFMIOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:14:08 -0400
Subject: Re: RTC causes hard lockups in 2.5.70-mm8
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55L-032.0306122205210.4915@unix48.andrew.cmu.edu>
References: <Pine.LNX.4.55L-032.0306122205210.4915@unix48.andrew.cmu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055492730.5162.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jun 2003 09:25:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-13 at 03:12, Nathaniel W. Filardo wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> If I set CONFIG_RTC=m and rebuild, when the kernel autoloads rtc.ko the
> system immediately locks hard, not responding even to magic SysRq series.
> Backing out either of the rtc-* patches from -mm8 does not seem to fix the
> problem.

It seems to be ALI + ACPI related but I dont yet understand what is
going on

