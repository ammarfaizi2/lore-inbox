Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263994AbTEFRK5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTEFRK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:10:56 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:55723
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S263994AbTEFRK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:10:56 -0400
Date: Tue, 6 May 2003 13:23:21 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Russell King <rmk@arm.linux.org.uk>
cc: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Marcus Meissner <meissner@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
In-Reply-To: <20030506181346.C15174@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305061320080.11648-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Russell King wrote:

> On Tue, May 06, 2003 at 05:32:52PM +0200, Jörn Engel wrote:
> > Maybe I was just thinking the wrong way. Given that my systems don't
> > use IDE, SCSI, a floppy or anything emulating one of them, like USB
> > storage or CF. I don't want MSDOS partitioning, but in fact, I don't
> > want any of the disk-centric code at all, fs/partitions is just a part
> > of that.
> 
> Maybe introducing a CONFIG_DISK option and making partitioning as a whole
> depend on that ?

According to Alan it's nearly possible to configure the block layer out 
entirely, which would be a good thing to associate with a CONFIG_DISK option 
too.


Nicolas

