Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUHGQiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUHGQiC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 12:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUHGQiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 12:38:02 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:19344 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263713AbUHGQiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 12:38:00 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Nicholas Miell <nmiell@attbi.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mj@ucw.cz, James.Bottomley@steeleye.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <200408071217.i77CHUKm006973@burner.fokus.fraunhofer.de>
References: <200408071217.i77CHUKm006973@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Message-Id: <1091896677.2821.4.camel@entropy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.njm.1) 
Date: Sat, 07 Aug 2004 09:37:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-07 at 05:17, Joerg Schilling wrote:
> >From the > 20 platforms that libscg provides abstractions from, _most_
> platforms do not allow the "UNIX" /dev/something method to work with
> Generic SCSI:
> 
[ long list omitted ]
> 
> These are the platforms where /dev/something could work:
> 
[ shorter list omitted ]
> 
> As you see, the vast majority does not allow the addressing method the
> people on LKML seem to prefer recently.
> 
> Jrg

As a user of cdrecord, could you explain to me why referring to my CD
burner as 1,0,0 is preferable to /dev/cdrw?

-- Nicholas

