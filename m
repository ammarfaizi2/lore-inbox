Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263914AbTEOENm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 00:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbTEOENm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 00:13:42 -0400
Received: from windlord.Stanford.EDU ([171.64.19.147]:23695 "HELO
	windlord.stanford.edu") by vger.kernel.org with SMTP
	id S263913AbTEOENk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 00:13:40 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Garance A Drosihn <drosih@rpi.edu>, Jan Harkes <jaharkes@cs.cmu.edu>,
       David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <openafs-devel@openafs.org>
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
References: <Pine.LNX.4.44.0305141749490.28007-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305141749490.28007-100000@home.transmeta.com> (Linus
 Torvalds's message of "Wed, 14 May 2003 17:57:43 -0700 (PDT)")
From: Russ Allbery <rra@stanford.edu>
Organization: The Eyrie
Date: Wed, 14 May 2003 21:26:23 -0700
Message-ID: <ylel30zvgw.fsf@windlord.stanford.edu>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Portable Code,
 sparc-sun-solaris2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> Yeah, and the thing I think it _totally_ and utterly broken is that
> there can be only one of these per process.

> I don't see where the 1:1 idea comes from, except from a bad
> implementation.

If a single process is in possession of multiple sets of credentials at
the same time, how does the file system code in the kernel know which ones
to use for a given operation with a network file system?

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
