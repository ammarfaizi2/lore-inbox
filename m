Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSFPUoE>; Sun, 16 Jun 2002 16:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSFPUoD>; Sun, 16 Jun 2002 16:44:03 -0400
Received: from mons.uio.no ([129.240.130.14]:46781 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S316548AbSFPUoD>;
	Sun, 16 Jun 2002 16:44:03 -0400
To: Roberto Nibali <ratz@drugphish.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS (vfs-related) syscall logging
References: <3D0A5E64.3020705@drugphish.ch>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 16 Jun 2002 22:44:01 +0200
In-Reply-To: <3D0A5E64.3020705@drugphish.ch>
Message-ID: <shsadpv7y3y.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Roberto Nibali <ratz@drugphish.ch> writes:

     > I will extend it and add yet another proc-fs variable in
     > /proc/sys/sunrpc/ which will represent a bitmask to selectively
     > enable/disable which syscalls should be logged.


Ugh...

The volume of information you propose to log is going to be seriously
huge and *will* affect performance. It would probably be a lot more
efficient to log using 'tcpdump' (and the libpcap binary format)
instead of all those printks.

Cheers,
  Trond
