Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129740AbRCTOXc>; Tue, 20 Mar 2001 09:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130253AbRCTOXV>; Tue, 20 Mar 2001 09:23:21 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:3844 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129740AbRCTOXU>; Tue, 20 Mar 2001 09:23:20 -0500
Date: Tue, 20 Mar 2001 11:16:04 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: acc@CS.Stanford.EDU, linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
Subject: Re: [CHECKER] 16 potential locking bugs in 2.4.1
In-Reply-To: <15030.60317.715787.369652@dulcimer.orchestra.cse.unsw.EDU.AU>
Message-ID: <Pine.LNX.4.21.0103201115350.24054-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Neil Brown wrote:
> On Friday March 16, acc@CS.Stanford.EDU wrote:

> > | fs/nfsd/vfs.c                   | nfsd_link                  |
> > | fs/nfsd/vfs.c                   | nfsd_symlink               |
> 
> These are not actually bugs.  The usage of fh_lock is fairly obscure.
> The unlock gets done by an fh_put which the caller does after calling
> nfsd_link or nfs_symlink.

Sounds like a "bug waiting to be implemented"   ;)

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

