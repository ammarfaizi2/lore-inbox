Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbTEaN5i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 09:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264336AbTEaN5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 09:57:38 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:46531 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264335AbTEaN5g
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sat, 31 May 2003 09:57:36 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16088.47088.814881.791196@laputa.namesys.com>
Date: Sat, 31 May 2003 18:10:56 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: const from include/asm-i386/byteorder.h
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta11) "cabbage" XEmacs Lucid
Microsoft: We've got the solution for the problem we sold you.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

include/asm-i386/byteorder.h contains strange __const__'s in function
definitions that have no effect:

static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
static __inline__ __const__ __u16 ___arch__swab16(__u16 x)

What is their meaning?

Nikita.
