Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUHGPEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUHGPEo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 11:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUHGPEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 11:04:44 -0400
Received: from the-village.bc.nu ([81.2.110.252]:10946 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262932AbUHGPEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 11:04:42 -0400
Subject: Re: ide-cd problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Charles Cazabon <linux@discworld.dyndns.org>
Cc: Jens Axboe <axboe@suse.de>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040806151455.GE29393@discworld.dyndns.org>
References: <20040731153609.GG23697@suse.de> <20040731182741.GA21845@bliss>
	 <20040731200036.GM23697@suse.de> <20040731210257.GA22560@bliss>
	 <20040805054056.GC10376@suse.de>
	 <1091739966.8418.38.camel@localhost.localdomain>
	 <20040806054424.GB10274@suse.de> <20040806062331.GE10274@suse.de>
	 <1091794470.16306.11.camel@localhost.localdomain>
	 <20040806143258.GB23263@suse.de>
	 <20040806151455.GE29393@discworld.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091887315.18407.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 15:01:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-06 at 16:14, Charles Cazabon wrote:
> > That's the case I don't agree with, and why I didn't like the idea
> > originally. That suddenly requires a patching of the kernel because of
> > new commands in new devices. Like when dvd readers became common, you
> > can't just require people to update their kernel because a few new
> > commands are needed to drive them from user space.
> 
> The problem is that what if one of the new commands is IGNITE_PLATTER?
> Unknown commands can do anything, are therefore extremely dangerous, and
> should be restricted.

The comands in question already include such gems as "format", "erase
firmware" and the like. So if you've got read access to a 2.6 raw block
device you can reformat your oracle database. 

Alan

