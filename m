Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbREYUbm>; Fri, 25 May 2001 16:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbREYUbb>; Fri, 25 May 2001 16:31:31 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41153 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261837AbREYUb2>;
	Fri, 25 May 2001 16:31:28 -0400
Date: Fri, 25 May 2001 16:31:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Subject: [CFT][PATCH] namespaces patch (2.4.5-pre6)
Message-ID: <Pine.GSO.4.21.0105251621400.28097-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, new version of the patch is on
ftp.math.psu.edu/pub/viro/namespaces-c-S5-pre6.gz

	News:
* ported to 2.4.5-pre6
* new (cleaner) locking mechanism
* lock_super() is starting to become fs-private thing - first steps to
  removing it from VFS code are done.

Please, help with testing. I'm feeding the pieces suitable for 2.4 into
the Linus' tree, so patch got smaller.

It works here(tm). It had survived rather sadistic tortu^Wtesting, but I
am _very_ interested in more eyes going through the thing and more people
giving it a beating.
							Al

