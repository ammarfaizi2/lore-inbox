Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSKCRDS>; Sun, 3 Nov 2002 12:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSKCRDS>; Sun, 3 Nov 2002 12:03:18 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:2432 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S262208AbSKCRDR>;
	Sun, 3 Nov 2002 12:03:17 -0500
Date: Sun, 3 Nov 2002 11:10:23 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Working ide-cd burn/rip, 2.5.44
Message-Id: <20021103111023.0412c98e.arashi@arashi.yi.org>
In-Reply-To: <20021103163452.GA11068@suse.de>
References: <20021102184357.7091fd4d.arashi@arashi.yi.org>
	<20021103094229.GJ3612@suse.de>
	<20021103102902.77ae876b.arashi@arashi.yi.org>
	<20021103163452.GA11068@suse.de>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002 17:34:52 +0100
Jens Axboe <axboe@suse.de> wrote:

> On Sun, Nov 03 2002, Matt Reppert wrote:
> > 3-arashi:~$ /opt/schily/bin/cdrecord dev=ATAPI:0,0,0 -checkdrive
> 
> use open by device name, ie dev=/dev/hdX

Ah ... that makes all the difference. My bad. Works under 2.5.45
as well. (I blame ide-scsi for continuing to make me think like my
CDRW is on a SCSI bus somewhere ... ^^; )

Thanks,
Matt
