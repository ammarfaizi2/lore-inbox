Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276642AbSIVG0N>; Sun, 22 Sep 2002 02:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276646AbSIVG0N>; Sun, 22 Sep 2002 02:26:13 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:14060 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276642AbSIVG0M>;
	Sun, 22 Sep 2002 02:26:12 -0400
Date: Sun, 22 Sep 2002 02:31:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Aniruddha Shankar <ashankar@nls.ac.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: make bzImage fails on 2.5.38
In-Reply-To: <1999.202.54.87.179.1032675381.squirrel@mail.nls.ac.in>
Message-ID: <Pine.GSO.4.21.0209220229480.22740-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Sep 2002, Aniruddha Shankar wrote:

> First post to the list, I've followed the format given in REPORTING-BUGS
> 
> 1. make bzImage fails on 2.5.38

Arrgh.

ed fs/partitions/check.c <<EOF
365s/devfs_handle/cdroms/
w
q
EOF

