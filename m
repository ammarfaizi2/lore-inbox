Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130330AbRBZQoM>; Mon, 26 Feb 2001 11:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbRBZQoE>; Mon, 26 Feb 2001 11:44:04 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32492 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130325AbRBZQnt>;
	Mon, 26 Feb 2001 11:43:49 -0500
Date: Mon, 26 Feb 2001 11:43:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <Pine.GSO.4.21.0102260742380.29386-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0102261137540.79-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	New version uploaded on ftp.math.psu.edu/pub/viro/namespaces-a-S2.gz
Changes:
	* nosuid, nodev and noexec are per-mountpoint now.
	* new flag for mount() - MS_MOVE (move a subtree, probable syntax
for mount(8) - mount --move old new; old must be a mountpoint)
	* Fixes for "lazy" umount.
	* CLONE_NEWNS is made root-only (CAP_SYS_ADMIN, actually)

Folks, please help with testing. Again, It Works Here(tm).
							Cheers,
								Al

