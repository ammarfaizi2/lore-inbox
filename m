Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317786AbSGPMkl>; Tue, 16 Jul 2002 08:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317790AbSGPMkk>; Tue, 16 Jul 2002 08:40:40 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:46520 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S317786AbSGPMkj>; Tue, 16 Jul 2002 08:40:39 -0400
Date: Tue, 16 Jul 2002 14:43:31 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: linux-kernel@vger.kernel.org, Sam Vilain <sam@vilain.net>,
       dax@gurulabs.com
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716124331.GJ7955@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	linux-kernel@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	dax@gurulabs.com
References: <1026490866.5316.41.camel@thud> <1026679245.15054.9.camel@thud> <E17U1BD-0000m0-00@hofmann> <1026736251.13885.108.camel@irongate.swansea.linux.org.uk> <E17U4YE-0000TL-00@hofmann> <20020715160357.GD442@clusterfs.com> <E17U9x9-0001Dc-00@hofmann> <20020716081531.GD7955@tahoe.alcove-fr> <20020716122756.GD4576@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716122756.GD4576@merlin.emma.line.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 02:27:56PM +0200, Matthias Andree wrote:

> > Come on, who REALLY expects to have consistent backups without
> > either unmounting the filesystem or using some snapshot techniques ?
> 
> The who uses [s|g]tar, cpio, afio, dsmc (Tivoli distributed storage
> manager), ...
> 
> Low-level snapshots don't do any good, they just freeze the "halfway
> there" on-disk structure.

But [s|g]tar, cpio, afio (don't know about dsmc) also freeze the
"halfway there" data, but at the file level instead (application
instead of filesystem)...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
