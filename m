Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268871AbUHLW5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268871AbUHLW5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268869AbUHLWyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:54:25 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:34500 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S268865AbUHLWvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:51:37 -0400
Date: Thu, 12 Aug 2004 18:51:35 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Alan Cox <alan@www.pagan.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
In-Reply-To: <1092341803.22458.37.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0408121844001.10369@vivaldi.madbase.net>
References: <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org>
 <1092313030.21978.34.camel@localhost.localdomain>
 <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
 <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org>
 <1092341803.22458.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Aug 2004, Alan Cox wrote:
> In essence the interface (and the SCSI/ATA/.. layers below) don't
> seperate media and device. This also kicks in for partitioning since
> write access to /dev/hda1 giving me SG_IO scsi access doesn't enforce
> partitioning.

But who needs SG_IO on partition devices?
Why not simply disallow it completely for non-root users?

Eric
