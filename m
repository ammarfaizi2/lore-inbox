Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUHDGr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUHDGr6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 02:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266730AbUHDGr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 02:47:58 -0400
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:62912 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S267315AbUHDGrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 02:47:18 -0400
Date: Wed, 4 Aug 2004 08:47:16 +0200
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: NFS-mounted, read-only /dev unusable in 2.6
Message-ID: <20040804064716.GA31600@traveler.cistron.net>
Reply-To: linux-kernel@vger.kernel.org
References: <410F481C.9090408@bio.ifi.lmu.de> <64bf.410f9d6f.62af@altium.nl> <ceouv0$7s8$2@news.cistron.nl> <41108380.6080809@bio.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <41108380.6080809@bio.ifi.lmu.de> (from fsteiner-mail@bio.ifi.lmu.de on Wed, Aug 04, 2004 at 08:34:40 +0200)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.08.04 08:34, Frank Steiner wrote:
> Miquel van Smoorenburg wrote:
> 
> > If having /dev mounted read-only means you cannot open devices
> > like /dev/console read/write then that is a bug in the NFS client
> > in the kernel.
> 
> Which matches the fact the it works with server running 2.6 and
> client running 2.4.
> 
> > 
> > On all other filesystems (ext2, ext3, xfs etc) there's no problem
> > opening devices r/w on a read-only filesystem.
> 
> Should I report that as bug to someone special?

Assuming you have a way to reproduce this, to the NFS client
maintainer - see the file MAINTAINERS in the kernel source.

But I just tried to reproduce this on 2.6.7-rc2 (it's what my
workstation happens to be running) and I can't. I can mount an
nfs-exported /dev from both 2.4 and 2.6 servers read-only and
I can open devices on that read-only mount just fine.

Mike.
-- 
The question is, what is a "manamanap".
The question is, who cares ?
