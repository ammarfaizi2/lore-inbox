Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277785AbRJLRMc>; Fri, 12 Oct 2001 13:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277783AbRJLRMX>; Fri, 12 Oct 2001 13:12:23 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:59146 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S277785AbRJLRMG>; Fri, 12 Oct 2001 13:12:06 -0400
Date: Fri, 12 Oct 2001 10:08:39 -0700 (PDT)
From: Mike Borrelli <mike@nerv-9.net>
To: linux-kernel@vger.kernel.org
Subject: No love for the PPC
Message-ID: <Pine.LNX.4.21.0110121002200.13818-100000@asuka.nerv-9.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry about the tone of this e-mail, but it is somewhat painful when,
after downloading a new kernel to play with, it doesn't compile on the
ppc.  It isn't even big problems either.  A single line (#include
<linux/pm.h>) is missing from pc_keyb.c and has been for at least three
-ac releases.  Now, process.c in arch/ppc/kernel/ dies from an undeclared
identifier (init_mmap).

I'm sure the appropriate response would be to fix them myself, but I don't
know enough about the kernel or the ppc arhitecture.  I'm also sure that
if Theo (or anyone like him) was to read this s/he would tell me to stop
whining.

Anyway, the real question is, why does the ppc arhitecture /always/ break
between versions?

I'll stop complaining now.

Regards,
-Mike

