Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbTCGLgD>; Fri, 7 Mar 2003 06:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261517AbTCGLgD>; Fri, 7 Mar 2003 06:36:03 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36265
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261521AbTCGLgC>; Fri, 7 Mar 2003 06:36:02 -0500
Subject: Re: 2.5.64p5 No USB support when APIC mode enabled
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Meino Christian Cramer <mccramer@s.netic.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030307.084425.41197714.mccramer@s.netic.de>
References: <20030306130340.GA453@zip.com.au>
	 <20030306132904.A838@flint.arm.linux.org.uk>
	 <20030307.084425.41197714.mccramer@s.netic.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047041536.20794.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 12:52:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need at least 2.4.21-pre5-ac, or 2.5.64-ac (I just sent Linus the
relevant changes) to use APIC on the VIA chipset systems. You also need
a BIOS with correct tables, which can also be a little tricky to find
in uniprocessordom

