Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbTAFOwp>; Mon, 6 Jan 2003 09:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266876AbTAFOwp>; Mon, 6 Jan 2003 09:52:45 -0500
Received: from ligur.expressz.com ([212.24.178.154]:16776 "EHLO expressz.com")
	by vger.kernel.org with ESMTP id <S266546AbTAFOwn>;
	Mon, 6 Jan 2003 09:52:43 -0500
Date: Mon, 6 Jan 2003 15:59:49 +0100 (CET)
From: "BODA Karoly jr." <woockie@expressz.com>
To: James Morris <jmorris@intercode.com.au>
cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.54-sparc64 compile errors
In-Reply-To: <Mutt.LNX.4.44.0301041126480.19977-100000@blackbird.intercode.com.au>
Message-ID: <Pine.LNX.3.96.1030106155824.9268B-100000@ligur.expressz.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jan 2003, James Morris wrote:

> > WARNING: Error inserting lockd (/lib/modules/2.5.54/kernel/fs/lockd/lockd.ko): Cannot allocate memory
> > FATAL: Error inserting nfs (/lib/modules/2.5.54/kernel/fs/nfs/nfs.ko): Cannot allocate memory
> Try Rusty's sh_link patch:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104157163822921&w=2

	Yes, thank you. It works now :)

mortimer:~# uname -a
Linux mortimer 2.5.54 #14 Sat Jan 4 01:32:19 CET 2003 sparc64 unknown unknown GNU/Linux
mortimer:~# lsmod
Module                  Size  Used by
nfs                   111288  0
lockd                  49400  1 nfs
sunrpc                 92088  2 nfs lockd

-- 
						Woockie
..."what is there in this world that makes living worthwhile?"
Death thought about it. "CATS," he said eventually, "CATS ARE NICE."
			           (Terry Pratchett, Sourcery)

