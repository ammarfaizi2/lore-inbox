Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUJWDpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUJWDpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUJWDnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 23:43:53 -0400
Received: from gold.pobox.com ([208.210.124.73]:22449 "EHLO gold.pobox.com")
	by vger.kernel.org with ESMTP id S268274AbUJWDla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 23:41:30 -0400
Date: Fri, 22 Oct 2004 20:41:27 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       roland@redhat.com, jdewand@redhat.com, barryn@pobox.com
Subject: [PATCH][2.4] ELF fixes for executables with huge BSS (0/2)
Message-ID: <20041023034127.GA26813@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have ported the following two patches (from 2.6.x and the Red Hat
Enterprise Linux 3 kernel) to kernel 2.4.27 and up. The first patch
fixes a segfault that I've seen with Fortran programs that have huge
statically allocated arrays. The second patch, it seems to me, is a
further fix that is necessitated by the first patch.

[PATCH] fix ELF exec with huge bss
http://linux.bkbits.net:8080/linux-2.5/cset@3ff112802L-9-rs0BbkozDnTnpch9w

[PATCH] binfmt_elf.c fix for 32-bit apps with large bss
http://linux.bkbits.net:8080/linux-2.5/cset@407afc8e4kEZSl4pklf3Ptrl2ZzkeA

I will post the patches as replies to this e-mail. If it's too
late to include them in 2.4.28, then I would appreciate if they
could be added to the queue for 2.4.29. Thanks!

-Barry K. Nathan <barryn@pobox.com>

