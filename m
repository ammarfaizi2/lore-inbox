Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317997AbSGQDna>; Tue, 16 Jul 2002 23:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318204AbSGQDn3>; Tue, 16 Jul 2002 23:43:29 -0400
Received: from windlord.Stanford.EDU ([171.64.13.23]:170 "HELO
	windlord.stanford.edu") by vger.kernel.org with SMTP
	id <S317997AbSGQDn3>; Tue, 16 Jul 2002 23:43:29 -0400
To: Zack Weinberg <zack@codesourcery.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs
 benchmarks)
References: <fa.lfdnrtv.5h8i1j@ifi.uio.no> <fa.i1e82rv.1digoa4@ifi.uio.no>
In-Reply-To: <fa.i1e82rv.1digoa4@ifi.uio.no> (Zack Weinberg's message of
 "Tue, 16 Jul 2002 23:23:34 GMT")
From: Russ Allbery <rra@stanford.edu>
Organization: The Eyrie
Date: Tue, 16 Jul 2002 20:46:20 -0700
Message-ID: <ylador3tkj.fsf@windlord.stanford.edu>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 sparc-sun-solaris2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zack Weinberg <zack@codesourcery.com> writes:

> Consider: There is no guarantee that close will detect errors.  Only
> NFS and Coda implement f_op->flush methods.

And AFS, I believe.  (Not in the standard kernel, of course.)

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
