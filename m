Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbTEFSRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbTEFSRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:17:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33773 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264002AbTEFSRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:17:49 -0400
Date: Tue, 6 May 2003 20:30:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nicolas Pitre <nico@cam.org>, Russell King <rmk@arm.linux.org.uk>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Marcus Meissner <meissner@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
Message-ID: <20030506183010.GK905@suse.de>
References: <Pine.LNX.4.44.0305061320080.11648-100000@xanadu.home> <1052241988.1202.36.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052241988.1202.36.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06 2003, Alan Cox wrote:
> On Maw, 2003-05-06 at 18:23, Nicolas Pitre wrote:
> > According to Alan it's nearly possible to configure the block layer out 
> > entirely, which would be a good thing to associate with a CONFIG_DISK option 
> > too.
> 
> David Woodhouse I believe..

Are we talking about everything below submit_bh/bio? Shouldn't be too
hard to write a small no-block.c for that...

-- 
Jens Axboe

