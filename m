Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267080AbSKTAIQ>; Tue, 19 Nov 2002 19:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267395AbSKTAIP>; Tue, 19 Nov 2002 19:08:15 -0500
Received: from host194.steeleye.com ([66.206.164.34]:22027 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267080AbSKTAIO>; Tue, 19 Nov 2002 19:08:14 -0500
Message-Id: <200211200015.gAK0FDc05837@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: james.bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] voyager sysrq usage 
In-Reply-To: Message from "Randy.Dunlap" <rddunlap@osdl.org> 
   of "Tue, 19 Nov 2002 15:21:20 PST." <Pine.LNX.4.33L2.0211191516120.27979-100000@dragon.pdx.osdl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 19 Nov 2002 18:15:13 -0600
From: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rddunlap@osdl.org said:
> BTW, how does someone enable CONFIG_VOYAGER to build a Voyager kernel?

Ah, well, you need the rest of the voyager patches which include the Kconfig 
stuff (or they're in the -ac tree).

rddunlap@osdl.org said:
> This patch (to 2.5.48 plain) moves the Voyager sysrq dump key from 'C'
> to 'V' and makes the 'V' a capital V in the help_msg. The latter is
> the way that the other sysrq help messages indicate which character
> key to use to invoke them, and it would be good if the Voyager sysrq
> dump did the same. 

There was a reason for 'C' a long time ago, but I've forgotten what it was.  
I'll move it to 'V' thanks.

James




