Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273116AbRIJAkb>; Sun, 9 Sep 2001 20:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273117AbRIJAkL>; Sun, 9 Sep 2001 20:40:11 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:16018 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S273116AbRIJAkD>;
	Sun, 9 Sep 2001 20:40:03 -0400
Date: Sun, 9 Sep 2001 17:39:47 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010909173947.A20202@netnation.com>
In-Reply-To: <Pine.LNX.4.33L.0109090909001.21049-100000@duckman.distro.conectiva> <Pine.LNX.4.33.0109091105380.14479-100000@penguin.transmeta.com> <9ngirh$jsu$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ngirh$jsu$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 01:18:57PM -0700, H. Peter Anvin wrote:

> The main reason people seems to still justify use dump/restore is --
> believe it or not -- the inability to set atime.  One would think this
> would be a trivial extension to the VFS, even if protected by a
> capability (CAP_BACKUP?).

What do people actually use atime for, anyway?  I've always
noatime/nodiratime'd most servers I've set up because it saves so much
disk I/O, and I have yet to see anything really use it.  I can see that
in some cases it would be useful to turn it _on_ (perhaps for debugging /
removal of unused files, etc.), but it seems silly that the default case
is a situation which on the surface seems dumb (opening a file for read
causes a disk write).

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
