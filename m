Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131368AbQLLBOI>; Mon, 11 Dec 2000 20:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131586AbQLLBNt>; Mon, 11 Dec 2000 20:13:49 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:64778 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131525AbQLLBNm>; Mon, 11 Dec 2000 20:13:42 -0500
Date: Mon, 11 Dec 2000 18:43:05 -0600
To: "John O'Donnell" <johnod@voicefx.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: YUP- Almost 2.2.18
Message-ID: <20001211184305.A3199@cadcamlab.org>
In-Reply-To: <3A349C12.4000408@voicefx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A349C12.4000408@voicefx.com>; from johnod@voicefx.com on Mon, Dec 11, 2000 at 04:19:14AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[John O'Donnell]
> The directory of kernel headers (version 2.2.17) does not match your
> running kernel (version 2.2.18). Consequently, even if the
> compilation of the module wassuccessful, the module would not load
> into the running kernel.

> Upon inspection of /usr/src/linux/include/linux/version.h
> it plainly says 2.2.17.... ????  I changed it to 2.2.18 and all is well.

version.h is an auto-generated file (see the first four lines of the
toplevel Makefile for the correct version definition).  It is generated
when you compile the kernel.  If you unpacked the tree (or patched a
2.2.17 tree) *without* compiling anything, version.h (and compile.h,
which is created at about the same time) will be either missing or
wrong.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
