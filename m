Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753241AbWKCLrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbWKCLrx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 06:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbWKCLrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 06:47:53 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:50639 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1753241AbWKCLrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 06:47:52 -0500
Date: Fri, 3 Nov 2006 12:47:51 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Gabriel C <nix.or.die@googlemail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <454AA4C5.3070106@googlemail.com>
Message-ID: <Pine.LNX.4.64.0611031247130.17174@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <454A71EB.4000201@googlemail.com> <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
 <454AA4C5.3070106@googlemail.com>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This error looks fixed, now I have a new one here :)
>
> cc -D__NOT_FROM_SPAD -D__NOT_FROM_SPAD_TREE -Wall
> -fdollars-in-identifiers -O2 -fomit-frame-pointer -c -o MKSPADFS.o -x c
> MKSPADFS.C
> MKSPADFS.C:146: error: expected declaration specifiers or '...' before
> '_llseek'
> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'fd'
> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'hi'
> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'lo'
> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'res'
> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'wh'
> MKSPADFS.C:146: warning: type defaults to 'int' in declaration of
> '_syscall5'
> In file included from MKSPADFS.C:153:
> GETHSIZE.I: In function 'test_access':
> GETHSIZE.I:13: warning: implicit declaration of function '_llseek'
> make: *** [MKSPADFS.o] Error 1

Pls send me output of C preprocessor. (i.e. gcc -E)

Mikulas
