Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267366AbTBFRbG>; Thu, 6 Feb 2003 12:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267370AbTBFRbG>; Thu, 6 Feb 2003 12:31:06 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:50184 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S267366AbTBFRbF>; Thu, 6 Feb 2003 12:31:05 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Date: 6 Feb 2003 17:16:39 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <b1u59n$lhl$1@abraham.cs.berkeley.edu>
References: <200302061502.KAA06538@moss-shockers.ncsc.mil> <20030206151820.A11019@infradead.org>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1044551799 22069 128.32.153.211 (6 Feb 2003 17:16:39 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 6 Feb 2003 17:16:39 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig  wrote:
>Well, selinux is still far from a mergeable shape and even needed additional
>patches to the LSM tree last time I checked.  This think of submitting hooks
>for code that obviously isn't even intende to be merged in mainline is what
>I really dislike, and it's the root for many problems with LSM.

You keep bringing up SELinux.  Maybe you dislike SELinux; I don't know.
In any case, LSM is not there just to support SELinux.  It's intended
to support a broad range of security modules and security policies.
LSM is bigger than just SELinux.
