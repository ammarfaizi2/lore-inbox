Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287681AbSASXxb>; Sat, 19 Jan 2002 18:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287697AbSASXxW>; Sat, 19 Jan 2002 18:53:22 -0500
Received: from 213-98-126-44.uc.nombres.ttd.es ([213.98.126.44]:44222 "HELO
	mitica.trasno.org") by vger.kernel.org with SMTP id <S287681AbSASXxO>;
	Sat, 19 Jan 2002 18:53:14 -0500
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext2 module in 2.4.18-pre4 broken?
In-Reply-To: <1011476968.1362.53.camel@psuedomode>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <1011476968.1362.53.camel@psuedomode>
Date: 20 Jan 2002 00:49:02 +0100
Message-ID: <m27kqdvr4h.fsf@trasno.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "ed" == Ed Sweetman <ed.sweetman@wmich.edu> writes:

ed> Making ext2 as a module in 2.4.18-pre4 seems to be broken.
ed> depmod: *** Unresolved symbols in
ed> /lib/modules/2.4.18-pre4/kernel/fs/ext2/ext2.o
ed> depmod:         waitfor_one_page



ed> is this true or just something patching seems to have messed up over the
ed> versions?

Read the archive.  Just a bug, you need to export that variable from
kernel/ksyms.c.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
