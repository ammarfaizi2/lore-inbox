Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTEOGDm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 02:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTEOGDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 02:03:42 -0400
Received: from relay03.roc.ny.frontiernet.net ([66.133.131.36]:41938 "EHLO
	relay03.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S263921AbTEOGDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 02:03:41 -0400
Date: Thu, 15 May 2003 02:16:30 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Cc: adilger@clusterfs.com
Subject: Re: O_DIRECT write to file by block-aligned, block-multiple buf fails?
Message-ID: <20030515021630.I1532@newbox.localdomain>
References: <20030515013350.B1540@newbox.localdomain> <20030515000417.D10503@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030515000417.D10503@schatzie.adilger.int>; from adilger@clusterfs.com on Thu, May 15, 2003 at 12:04:17AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger on Thu 15/05 00:04 -0600:
> On May 15, 2003  01:33 -0400, Scott McDermott wrote:
> > This should mean I can write aligned pages with direct
> > IO, right?
> > 
> >         write: Invalid argument
> > 
> >         $ grep /tmp /proc/mounts
> >         /dev/hda5 /mnt/tmp ext3 rw 0 0
> 
> ext3 does not support O_DIRECT in 2.4 yet.

should open() on an ext3-based file fail when O_DIRECT is
among the flags?
