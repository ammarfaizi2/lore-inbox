Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136715AbREAU7D>; Tue, 1 May 2001 16:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136719AbREAU6x>; Tue, 1 May 2001 16:58:53 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:55314 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136715AbREAU6m>; Tue, 1 May 2001 16:58:42 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Maximum files per Directory
Date: 1 May 2001 13:58:06 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9cn80u$u19$1@cesium.transmeta.com>
In-Reply-To: <272800000.988750082@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <272800000.988750082@hades>
By author:    Andreas Rogge <lu01@rogge.yi.org>
In newsgroup: linux.dev.kernel
>
> While trying to create 100.000 (in words: one hundred thousand) Mailboxes 
> with
> cyrus-imapd i ran into problems.
> At about 2^15 files the filesystem gave up, telling me that there cannot be
> more files in a directory.
> 
> Is this a vfs-Issue or an ext2-issue?
> 

Not correct, there can't be more than 2^15 *directories* in a single
directory.  I belive this is an ext2 limitation.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
