Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130169AbRBMFKI>; Tue, 13 Feb 2001 00:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130217AbRBMFJ5>; Tue, 13 Feb 2001 00:09:57 -0500
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:42236 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S130169AbRBMFJp>; Tue, 13 Feb 2001 00:09:45 -0500
Date: Mon, 12 Feb 2001 23:09:39 -0600 (CST)
From: Matt Stegman <mas9483@ksu.edu>
To: linux-kernel@vger.kernel.org
Subject: gzipped executables
Message-ID: <Pine.GSO.4.21L.0102122251040.24003-100000@unix2.cc.ksu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any kernel patch that would allow Linux to properly recognize,
and execute gzipped executables?

I know I could use binfmt_misc to run a wrapper script:

    decompress to /tmp/prog.decompressed
    execute /tmp/prog.decompressed
    rm /tmp/prog.decompressed

But that's not as clean, secure, or fast as the kernel transparently
decompressing & executing.  Is there a better way to do this?

      -Matt


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
