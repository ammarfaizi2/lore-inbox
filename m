Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbTBRMEK>; Tue, 18 Feb 2003 07:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267775AbTBRMEK>; Tue, 18 Feb 2003 07:04:10 -0500
Received: from angband.namesys.com ([212.16.7.85]:18560 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267771AbTBRMEH>; Tue, 18 Feb 2003 07:04:07 -0500
Date: Tue, 18 Feb 2003 15:14:07 +0300
From: Oleg Drokin <green@namesys.com>
To: John Cherry <cherry@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.61
Message-ID: <20030218151407.A14679@namesys.com>
References: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com> <1045510507.3406.12.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045510507.3406.12.camel@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Feb 17, 2003 at 11:35:07AM -0800, John Cherry wrote:

> Warning summary
[...]
>    fs/reiserfs: 1 warnings, 0 errors

Note that this warning comes from asm/string.h, when compiling
fs/reiserfs/prints.c
Warning itself is "strchr is defined but not used". It have nothing
to do with reiserfs at all. And I do not see why it is produced at all, since
strchr is declared "static inline".
(BTW, gcc 2.95 does not produces the warning).
Can somebody look at it please?

Bye,
    Oleg
