Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288896AbSATSST>; Sun, 20 Jan 2002 13:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288897AbSATSSI>; Sun, 20 Jan 2002 13:18:08 -0500
Received: from mons.uio.no ([129.240.130.14]:39919 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S288896AbSATSR7>;
	Sun, 20 Jan 2002 13:17:59 -0500
To: Steinar Hauan <hauan@cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17smp kernel oops in nfs client
In-Reply-To: <Pine.GSO.4.43L-024.0201191310210.4325-700000@unix1.andrew.cmu.edu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 20 Jan 2002 19:17:54 +0100
In-Reply-To: <Pine.GSO.4.43L-024.0201191310210.4325-700000@unix1.andrew.cmu.edu>
Message-ID: <shs7kqc6g4t.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Steinar Hauan <hauan@cmu.edu> writes:

     > hello,
     >   log monitoring revealed that a user processed crashed a few
     >   days ago and left an ooops message along with a zombie user
     >   process (in non-interruptible disk wait).

Hi,
  Did you find any other NFS related messages in your syslog? Short of
a bug in truncate_inode_pages(), I really can't see how this could
happen. Certainly whatever is was should at least have triggered a
couple of NFS warnings...

Cheers,
  Trond
