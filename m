Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265007AbUFGTWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265007AbUFGTWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 15:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265010AbUFGTWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 15:22:30 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:54496 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265007AbUFGTWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 15:22:19 -0400
To: =?iso-8859-1?Q?Andi_Kleen?= <ak@muc.de>
Subject: =?iso-8859-1?Q?Re:_Re:_new_icc_kernel_patch_available_(with_kernel_PGO)?=
From: <ingo@pyrillion.org>
Cc: <j.dittmer@portrix.net>, <linux-kernel@vger.kernel.org>
Message-Id: <5685161$108663562940c4be6d58edc6.52713007@config7.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 5685161
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Mon,  7 Jun 2004 21:20:02 +0200
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.134
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

as I stated before, I created a generic training set in phase 2 of the
three phases compilation process by utilizing the kernel in various
ways: fore- and background activities, networking, filesystems, etc.
The PGO kernel module and the PGO daemon pgod are included in the
newest patch. You can create your own specialized training set for your
specific task. That's the big advantage of kernel PGO. This is the
first patch using both technologies of the Intel C/C++ Compiler, IPO
(Inter Procedural Optimization) and PGO (Profile Guided Optimization),
together.

Andi Kleen <ak@muc.de> schrieb am 07.06.2004, 18:40:50:
>  writes:
> 
> > I published some preliminary results in the German Linux Magazine, which
> > are copyrighted now. Sorry.
> > Some hints: maximum performance gain approx. 40%, avg. perf. gain:
> > approx. 8%; computed by LMBench+OProfile (accurate CPU cycle
> > measurement, 10us timer resolution).
> 
> These were with profiling feedback, right? What training set did
> you use for it?
> 
> -Andi
