Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSAUO1Q>; Mon, 21 Jan 2002 09:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286968AbSAUO1H>; Mon, 21 Jan 2002 09:27:07 -0500
Received: from SMTP6.ANDREW.CMU.EDU ([128.2.10.86]:14094 "EHLO
	smtp6.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S286825AbSAUO1C>; Mon, 21 Jan 2002 09:27:02 -0500
Date: Mon, 21 Jan 2002 09:26:55 -0500 (EST)
From: Steinar Hauan <hauan@cmu.edu>
X-X-Sender: hauan@unix1.andrew.cmu.edu
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17smp kernel oops in nfs client
In-Reply-To: <shs7kqc6g4t.fsf@charged.uio.no>
Message-ID: <Pine.GSO.4.43L-024.0201210923360.2867-100000@unix1.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jan 2002, Trond Myklebust wrote:
> >>>>> " " == Steinar Hauan <hauan@cmu.edu> writes:
>
>      > hello,
>      >   log monitoring revealed that a user processed crashed a few
>      >   days ago and left an ooops message along with a zombie user
>      >   process (in non-interruptible disk wait).
>
>   Did you find any other NFS related messages in your syslog? Short of
> a bug in truncate_inode_pages(), I really can't see how this could
> happen. Certainly whatever is was should at least have triggered a
> couple of NFS warnings...

there are no nfs error or warning messages at all on either the server
or the client for one week prior to the crash. this includes logs created
by kern.* and *.debug entries in syslog.conf.

regards,
--
  Steinar Hauan, dept of ChemE  --  hauan@cmu.edu
  Carnegie Mellon University, Pittsburgh PA, USA

