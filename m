Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265564AbRFVXQd>; Fri, 22 Jun 2001 19:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbRFVXQX>; Fri, 22 Jun 2001 19:16:23 -0400
Received: from 200-206-139-161-br-arqfisb1.public.telesp.net.br ([200.206.139.161]:4870
	"EHLO blackjesus.async.com.br") by vger.kernel.org with ESMTP
	id <S265564AbRFVXQG>; Fri, 22 Jun 2001 19:16:06 -0400
Date: Fri, 22 Jun 2001 20:15:45 -0300 (BRT)
From: Christian Robottom Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: <NFS@lists.sourceforge.net>, <reiserfs-list@namesys.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] NFS Insanity, v2
In-Reply-To: <shs66do3ywo.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.32.0106222013430.183-100000@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jun 2001, Trond Myklebust wrote:

> Is libgkcontents.so in use on the client? If so it's a known problem:
> mmap() screws up the page cache invalidation routine
> invalidate_inode_page(). If you do the untar on the client, then all
> will be fine...

Hah! Yeah, you're right; both times it happened because mozilla was
running at the time. I can't have it untarred on the client because the
client isn't on every day. It's a minor nuisance now that I've understood
it.

Is there a fix in the works for this?

> However the last time your report was of a problem in which the server
> was corrupted, and the client was good. Was that a typo, or is it
> still the case?

Possible typo. I did the diff on the server so perhaps I gave the
impression the problem was there, and it wasn't.

Take care,
--
/\/\ Christian Reis, Senior Engineer, Async Open Source, Brazil
~\/~ http://async.com.br/~kiko/ | [+55 16] 274 4311

