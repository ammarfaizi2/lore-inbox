Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266771AbTGGANQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 20:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266773AbTGGANP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 20:13:15 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:61098 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266771AbTGGANP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 20:13:15 -0400
Date: Mon, 7 Jul 2003 02:30:07 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Message-ID: <20030707003007.GE4675@ns.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <20030706210243.GA25645@lea.ulyssis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030706210243.GA25645@lea.ulyssis.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting in smp mode now works using acpi=off and acpismp=force on the
kernel command line.

Could anyone care to comment what these options do ?

Would I be far off by saying that it disables the use of ACPI in the
kernel, except for setting up the APICs and the CPUs, for which it will
explicitly use the data provided by the ACPI BIOS ?

Is there something I'm missing by not using ACPI ? :)

best regards,

Vincent

PS: will test if the system still locks up soon, I hope not...
