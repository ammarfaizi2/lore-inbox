Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267408AbTAGQNX>; Tue, 7 Jan 2003 11:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267411AbTAGQNX>; Tue, 7 Jan 2003 11:13:23 -0500
Received: from waste.org ([209.173.204.2]:56004 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267408AbTAGQNX>;
	Tue, 7 Jan 2003 11:13:23 -0500
Date: Tue, 7 Jan 2003 10:21:47 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <20030107162147.GE10045@waste.org>
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org> <3E19B401.7A9E47D5@linux-m68k.org> <17360000.1041899978@localhost.localdomain> <1041942677.20658.0.camel@irongate.swansea.linux.org.uk> <27130000.1041942696@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27130000.1041942696@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 01:31:36AM +1300, Andrew McGregor wrote:
> Or ESP, with or without encryption as well.
> 
> But that does not acheive quite the same thing, because the iSCSI digest is 
> another lightweight checksum, albeit stronger than most, and does not 
> provide authentication.  So AH or ESP is stronger, but slower.
> 
> Maybe Cisco are assuming another layer deals with the errors.  However, to 
> get an interoperable and efficient implementation requires the capability 
> to do whatever combination is required, along with sensible defaults.

Actually, as I pointed out before, the current Cisco iSCSI driver does
support CRC (32-bit), though it's presumably off by default.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
