Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265209AbSJRUdo>; Fri, 18 Oct 2002 16:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265240AbSJRUdo>; Fri, 18 Oct 2002 16:33:44 -0400
Received: from mozart.CS.Berkeley.EDU ([128.32.153.211]:11909 "EHLO
	mozart.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id <S265209AbSJRUdn>; Fri, 18 Oct 2002 16:33:43 -0400
Date: Fri, 18 Oct 2002 13:36:47 -0700
From: David Wagner <daw@cs.berkeley.edu>
Message-Id: <200210182036.g9IKalF00634@mozart.cs.berkeley.edu>
To: linux-kernel@vger.kernel.org
X-Also-Posted-To: isaac.lists.linux-security-module
Subject: Re: [PATCH] remove sys_security
References: <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu> <20021018161828.A5523@infradead.org> <200210181830.28354.russell@coker.com.au> <20021018173339.A7481@infradead.org>
Distribution: isaac
Organization: University of California, Berkeley
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig  wrote:
>And exactly these hooks harm.  They are all over the place, have performance
>and code size impact and mess up readability.  Why can't you just maintain
>an external patch like i.e. mosix folks that nead similar deep changes?

Actually, this is not an accurate description of LSM.  As you may know,
the LSM hooks do not have a noticeable performance impact (with the
exception of 1Gb networking, where I believe there is a 1-2% slowdown).
This has been pointed out several times before, and the LSM folks have
posted a pointer to the measurements.
