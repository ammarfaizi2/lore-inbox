Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbTCCNLv>; Mon, 3 Mar 2003 08:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbTCCNLv>; Mon, 3 Mar 2003 08:11:51 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64666
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264915AbTCCNLu>; Mon, 3 Mar 2003 08:11:50 -0500
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bert hubert <ahu@ds9a.nl>
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@clear.net.nz>,
       Roger Luethi <rl@hellgate.ch>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030303123551.GA19859@outpost.ds9a.nl>
References: <20030226211347.GA14903@elf.ucw.cz>
	 <20030302133138.GA27031@outpost.ds9a.nl>
	 <1046630641.3610.13.camel@laptop-linux.cunninghams>
	 <20030302202118.GA2201@outpost.ds9a.nl>
	 <20030303003940.GA13036@k3.hellgate.ch>
	 <1046657290.8668.33.camel@laptop-linux.cunninghams>
	 <20030303113153.GA18563@outpost.ds9a.nl>
	 <20030303122325.GA20929@atrey.karlin.mff.cuni.cz>
	 <20030303123551.GA19859@outpost.ds9a.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046701499.5889.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 14:25:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 12:35, bert hubert wrote:
> This is a laptop with only one. Anything I can do to help, let me know. Alan
> has suggested that an IDE transaction was still in progress, perhaps a small
> wait could prove/disprove this assumption?

Two drives would make some sense as an easier trigger. An IDE command can only be
outstanding per interface not per device.

