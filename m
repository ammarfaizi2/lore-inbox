Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318920AbSICSha>; Tue, 3 Sep 2002 14:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318922AbSICSha>; Tue, 3 Sep 2002 14:37:30 -0400
Received: from dsl-213-023-043-116.arcor-ip.net ([213.23.43.116]:44437 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318920AbSICSh3>;
	Tue, 3 Sep 2002 14:37:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andreas Dilger <adilger@clusterfs.com>,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] mount flag "direct"
Date: Tue, 3 Sep 2002 20:44:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Lars Marowsky-Bree <lmb@suse.de>,
       linux kernel <linux-kernel@vger.kernel.org>
References: <200209031641.g83GfnD10219@oboe.it.uc3m.es> <Pine.LNX.4.44L.0209031425180.1519-100000@duckman.distro.conectiva> <20020903180243.GR32468@clusterfs.com>
In-Reply-To: <20020903180243.GR32468@clusterfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mIen-0005jC-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 20:02, Andreas Dilger wrote:
> Actually, we are using ext3 pretty much as-is for our backing-store
> for Lustre.  The same is true of InterMezzo, and NFS, for that matter.
> All of them live on top of a standard "local" filesystem, which doesn't
> know the things that happen above it to make it a network filesystem
> (locking, etc).

To put this in simplistic terms, this works because you treat the
underlying filesystem simply as a storage device, a slightly funky
kind of disk.

-- 
Daniel
