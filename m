Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261579AbTCGNaf>; Fri, 7 Mar 2003 08:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbTCGNaV>; Fri, 7 Mar 2003 08:30:21 -0500
Received: from host-212-9-163-181.dial.netic.de ([212.9.163.181]:26496 "EHLO
	solfire") by vger.kernel.org with ESMTP id <S261579AbTCGNaB>;
	Fri, 7 Mar 2003 08:30:01 -0500
Date: Fri, 07 Mar 2003 14:37:58 +0100 (MET)
Message-Id: <20030307.143758.74753985.mccramer@s.netic.de>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
From: Meino Christian Cramer <mccramer@s.netic.de>
In-Reply-To: <1047041536.20794.10.camel@irongate.swansea.linux.org.uk>
References: <20030306132904.A838@flint.arm.linux.org.uk>
	<20030307.084425.41197714.mccramer@s.netic.de>
	<1047041536.20794.10.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 3.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
X-SA-Exim-Rcpt-To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64p5 No USB support when APIC mode enabled
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.5.64p5 No USB support when APIC mode enabled
Date: 07 Mar 2003 12:52:16 +0000

Hi Alan, 

 thanks for your reply! 

 Unfortunately it does not solve the problem:
 As long as uhci (or USB per se) is not present, things do work.

 But uhci/USB get confused and repeats the message (in my last mail)
 endlessly i fcompbined with APIC mode.

 Therefore it seems that APIC is working with my VIA board without USB.
 But I cannot live without USB ... my mouse is USBish and X without a
 mouse is a little ... hmmm senseless.

 Any ideas else?

 Keep Hacking!
 Meino
 

> You need at least 2.4.21-pre5-ac, or 2.5.64-ac (I just sent Linus the
> relevant changes) to use APIC on the VIA chipset systems. You also need
> a BIOS with correct tables, which can also be a little tricky to find
> in uniprocessordom
> 
> 
