Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTD1Imp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 04:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTD1Imp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 04:42:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43316 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262284AbTD1Imo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 04:42:44 -0400
To: JXrn Engel <joern@wohnheim.fh-wedel.de>
Cc: rmoser <mlmoser@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Swap Compression
References: <200304251848410590.00DEC185@smtp.comcast.net>
	<20030426091747.GD23757@wohnheim.fh-wedel.de>
	<200304261148590300.00CE9372@smtp.comcast.net>
	<20030426160920.GC21015@wohnheim.fh-wedel.de>
	<200304262224040410.031419FD@smtp.comcast.net>
	<20030427090418.GB6961@wohnheim.fh-wedel.de>
	<200304271324370750.01655617@smtp.comcast.net>
	<20030427175147.GA5174@wohnheim.fh-wedel.de>
	<200304271431250990.01A281C7@smtp.comcast.net>
	<20030427190444.GC5174@wohnheim.fh-wedel.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Apr 2003 02:52:15 -0600
In-Reply-To: <20030427190444.GC5174@wohnheim.fh-wedel.de>
Message-ID: <m13ck3gg1s.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JXrn Engel <joern@wohnheim.fh-wedel.de> writes:

> Yes, zlib eats up several 100k of memory. You really notice this when
> you add it to a bootloader that was (once) supposed to be small. :)

I only measured about 32k for decompression.  But that was using
the variant from gzip via the kernel.

The really small algorithm I know about (at least for decompression)
is upx.  The compression is comparable with gzip with a decompressor
that can fit in a page or two of assembly code.

Probably irrelevant at this juncture but...

Eric

