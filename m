Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbTBJQru>; Mon, 10 Feb 2003 11:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbTBJQru>; Mon, 10 Feb 2003 11:47:50 -0500
Received: from mons.uio.no ([129.240.130.14]:60337 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S265037AbTBJQrt>;
	Mon, 10 Feb 2003 11:47:49 -0500
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS root: New error messages in latest bk
References: <3E47D057.4070205@walrond.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 10 Feb 2003 17:57:28 +0100
In-Reply-To: <3E47D057.4070205@walrond.org>
Message-ID: <shsfzqwxedj.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Walrond <andrew@walrond.org> writes:

     > Latest bk 2.5; Just booted with NFS root and noticed these new
     > error messages in dmesg:

     > NFS: server cheating in read reply: count 4096 > recvd 1000
     > NFS: giant filename in readdir (len 0xcb2d2053)!

     > Anybody know what this means?

It means that the client can only see 1000 out of a promised 4096
bytes. Either the client or the server has a bug. A tcpdump should
sort it out.

Cheers,
  Trond
