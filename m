Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSFEK1D>; Wed, 5 Jun 2002 06:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSFEK1D>; Wed, 5 Jun 2002 06:27:03 -0400
Received: from AMontpellier-205-1-4-20.abo.wanadoo.fr ([217.128.205.20]:22434
	"EHLO awak") by vger.kernel.org with ESMTP id <S314702AbSFEK1B> convert rfc822-to-8bit;
	Wed, 5 Jun 2002 06:27:01 -0400
Subject: Re: [rfc] "laptop mode"
From: Xavier Bestel <xavier.bestel@free.fr>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andreas Dilger <adilger@clusterfs.com>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CFD50B9.259366F4@zip.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Jun 2002 12:26:46 +0200
Message-Id: <1023272806.15438.106.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 05/06/2002 à 01:43, Andrew Morton a écrit :

> Also, it has been suggested that the feature become more fully-fleshed,
> to support desktops with one disk spun down, etc.  It's not really
> rocket science to do that - the `struct backing_dev_info' gives
> a specific communication channel between the high-level VFS code and
> the request queue.  But that would require significantly more surgery
> against the writeback code, so I'm fishing for requirements here.  If
> the current (simple) patch is sufficient then, well, it is sufficient.

Have per-disk laptop-mode, so that some user-mode proggy (e.g. hotplug)
could decide what to do.




