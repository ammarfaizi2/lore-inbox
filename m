Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316191AbSEKBzr>; Fri, 10 May 2002 21:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316192AbSEKBzq>; Fri, 10 May 2002 21:55:46 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:34222 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S316191AbSEKBzp>; Fri, 10 May 2002 21:55:45 -0400
Date: Sat, 11 May 2002 02:58:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG() disassembly tweak 
In-Reply-To: <2045.1021075213@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.21.0205110255410.2235-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002, Keith Owens wrote:
> On Fri, 10 May 2002 15:58:16 -0700, 
> Andrew Morton <akpm@zip.com.au> wrote:
> >
> >There will be no starting-with-slash __FILE__s in the output of
> >this command.
> 
> Separate source and object.  Multiple source trees to support
> additional drivers, filesystems etc.  kbuild 2.5 runs in the object
> directory, reading from the source directories.  Path names are
> absolute.

Is there some escaped syntax whereby we can (usefully) put
KBUILD_BASENAME into the BUG() macro in place of __FILE__?

Hugh

