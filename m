Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286283AbRLJPWu>; Mon, 10 Dec 2001 10:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286284AbRLJPWk>; Mon, 10 Dec 2001 10:22:40 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:7058 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286283AbRLJPW2>;
	Mon, 10 Dec 2001 10:22:28 -0500
Date: Mon, 10 Dec 2001 10:22:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [RFC] devfs=only and boot
Message-ID: <Pine.GSO.4.21.0112101019001.14238-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Richard, just how devfs=only is supposed to work with
loading ramdisk from floppies?

	BTW, with initrd exiting with real-root-dev set (regardless of
devfs=only) your code still goes by root_device_name and ignores new
ROOT_DEV.  Again, what behaviour is expected?

