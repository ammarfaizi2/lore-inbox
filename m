Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSHXPGS>; Sat, 24 Aug 2002 11:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSHXPGS>; Sat, 24 Aug 2002 11:06:18 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:43725 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316465AbSHXPGS>;
	Sat, 24 Aug 2002 11:06:18 -0400
Date: Sun, 25 Aug 2002 01:10:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Consolidate include/asm/fcntl.h into include/linux/fcntl.h
Message-Id: <20020825011020.267b1b90.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch consolidates as much as possible of the fcntl.h files into
include/linux/fcntl.h.  It builds fine on i386 but may have broken some
other architectures (but should not have) - I have been as careful as
I can.

Patch available at http://www.canb.auug.org.au/~sfr/31-fcntl.1.diff.gz

Comments welcome.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
