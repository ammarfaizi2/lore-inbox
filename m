Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSGPMZH>; Tue, 16 Jul 2002 08:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSGPMZG>; Tue, 16 Jul 2002 08:25:06 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:42758 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S314446AbSGPMZF>; Tue, 16 Jul 2002 08:25:05 -0400
Date: Tue, 16 Jul 2002 14:27:56 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: Stelian Pop <stelian.pop@fr.alcove.com>, Sam Vilain <sam@vilain.net>,
       dax@gurulabs.com
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716122756.GD4576@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Stelian Pop <stelian.pop@fr.alcove.com>, Sam Vilain <sam@vilain.net>,
	dax@gurulabs.com
References: <1026490866.5316.41.camel@thud> <1026679245.15054.9.camel@thud> <E17U1BD-0000m0-00@hofmann> <1026736251.13885.108.camel@irongate.swansea.linux.org.uk> <E17U4YE-0000TL-00@hofmann> <20020715160357.GD442@clusterfs.com> <E17U9x9-0001Dc-00@hofmann> <20020716081531.GD7955@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716081531.GD7955@tahoe.alcove-fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Stelian Pop wrote:

> Come on, who REALLY expects to have consistent backups without
> either unmounting the filesystem or using some snapshot techniques ?

The who uses [s|g]tar, cpio, afio, dsmc (Tivoli distributed storage
manager), ...

Low-level snapshots don't do any good, they just freeze the "halfway
there" on-disk structure.
