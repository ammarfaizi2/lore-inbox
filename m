Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTFBUg4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTFBUg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:36:56 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:30416 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262312AbTFBUgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:36:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16091.47243.33352.465537@gargle.gargle.HOWL>
Date: Mon, 2 Jun 2003 22:50:19 +0200
From: mikpe@csd.uu.se
To: Anders Gustafsson <andersg@0x63.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] Support for mach-xbox
In-Reply-To: <20030602202714.GD18786@h55p111.delphi.afb.lu.se>
References: <20030602202714.GD18786@h55p111.delphi.afb.lu.se>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Gustafsson writes:
 > Hi,
 > 
 > Attached is a patch that adds a new subachitecture for the xbox gaming
 > system. All it does outside the subarchitecture is adding posibility to
 > blacklist pci-devices through an mach-hook.
...
 > +config X86_XBOX
 > +	bool "XBox Gaming System"
 > +	help
 > +	  This option is needed to make Linux boot on XBox Gaming Systems.
 > +	  
 > +	  The XBox can be considered as a standard PC with a Pentium III Celeron 733 MHz,

There is no such thing as a "Pentium III Celeron". Presumably you meant
"Coppermine-based Celeron 733 MHz", but even that is uncertain.
Please post a /proc/cpuinfo copy from one of these boxes.

/Mikael
