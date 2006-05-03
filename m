Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWECNXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWECNXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWECNX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:23:29 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:48514 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030201AbWECNX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:23:27 -0400
Date: Wed, 3 May 2006 15:22:39 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>,
       mschwid2@de.ibm.com, Pekka J Enberg <penberg@cs.Helsinki.FI>
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060503132239.GA5250@wohnheim.fh-wedel.de>
References: <20060503130043.GC19537@wohnheim.fh-wedel.de> <OFF044ED40.56CCD284-ON42257163.0048A5F3-42257163.00491F2C@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OFF044ED40.56CCD284-ON42257163.0048A5F3-42257163.00491F2C@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006 15:18:41 +0200, Michael Holzheu wrote:
> 
> Of course! But the convention must be, that If userspace wants to
> access the data, it has to use our standard linux
> parser. If it accesses the data directly, this is broken.
> This ensures, that whitespaces do not matter at all! And as
> I said before, if you use the parser, you don't have any
> difference compared to the filesystem solution from a logical
> perspective.

o People are not forced to follow the convention.  If they don't and
  you break an existing application, you get the blame.
o Now you have a dependency on the standard parser, which is in
  userspace.  Any bug in any version of the standard parser and...

Jörn

-- 
There's nothing better for promoting creativity in a medium than
making an audience feel "Hmm ­ I could do better than that!"
-- Douglas Adams in a slashdot interview
