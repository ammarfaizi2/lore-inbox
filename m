Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267388AbTAGNJn>; Tue, 7 Jan 2003 08:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267389AbTAGNJn>; Tue, 7 Jan 2003 08:09:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:135
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267388AbTAGNJm>; Tue, 7 Jan 2003 08:09:42 -0500
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Andre Hedrick <andre@pyxtechnologies.com>,
       Oliver Xymoron <oxymoron@waste.org>, Andrew Morton <akpm@digeo.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <27130000.1041942696@localhost.localdomain>
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org>
	 <3E19B401.7A9E47D5@linux-m68k.org>
	 <17360000.1041899978@localhost.localdomain>
	 <1041942677.20658.0.camel@irongate.swansea.linux.org.uk>
	 <27130000.1041942696@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041947930.20658.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 07 Jan 2003 13:58:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 12:31, Andrew McGregor wrote:
> Or ESP, with or without encryption as well.
> 
> But that does not acheive quite the same thing, because the iSCSI digest is 
> another lightweight checksum, albeit stronger than most, and does not 
> provide authentication.  So AH or ESP is stronger, but slower.

AH permits multiple digests, they also happen to correspond to the hardware
accelerated ones on things like the 3c990...

