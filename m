Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317003AbSFWJBR>; Sun, 23 Jun 2002 05:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317004AbSFWJBQ>; Sun, 23 Jun 2002 05:01:16 -0400
Received: from mons.uio.no ([129.240.130.14]:14815 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317003AbSFWJBP>;
	Sun, 23 Jun 2002 05:01:15 -0400
To: Skip Gaede <sgaede@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory abuse with NFS Root filesystem?
References: <200206221648.36450.sgaede@attbi.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 23 Jun 2002 11:01:12 +0200
In-Reply-To: <200206221648.36450.sgaede@attbi.com>
Message-ID: <shs4rfuid2f.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Skip Gaede <sgaede@attbi.com> writes:

     > Local boot: slabinfo after 30 minutes: size-2048 5 50 2048 3 25
     > 1

     > NFS Root: slabinfo after 15 & 60 minutes size-2048 187 228 2048
     > 94 114 1 (15 min) size-2048 918 928 2048 460 464 1 (60 min)

     > Anyone ever seen or heard of this before? Any thoughts on how
     > to isolate this to a root cause?

Have you tried combining the 'local boot' test with NFS?

AFAICS there are no memory leaks on NFS with x86 systems, but there
might be something wierd going on with other architectures.

Cheers,
   Trond
