Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265584AbRFVXhR>; Fri, 22 Jun 2001 19:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265585AbRFVXhH>; Fri, 22 Jun 2001 19:37:07 -0400
Received: from pat.uio.no ([129.240.130.16]:16787 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S265584AbRFVXgw>;
	Fri, 22 Jun 2001 19:36:52 -0400
MIME-Version: 1.0
Message-ID: <15155.54917.265529.994551@charged.uio.no>
Date: Sat, 23 Jun 2001 01:36:37 +0200
To: Christian Robottom Reis <kiko@async.com.br>
Cc: <NFS@lists.sourceforge.net>, <reiserfs-list@namesys.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] NFS Insanity, v2
In-Reply-To: <Pine.LNX.4.32.0106222013430.183-100000@blackjesus.async.com.br>
In-Reply-To: <shs66do3ywo.fsf@charged.uio.no>
	<Pine.LNX.4.32.0106222013430.183-100000@blackjesus.async.com.br>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Robottom Reis <kiko@async.com.br> writes:

     > On 23 Jun 2001, Trond Myklebust wrote:
    >> Is libgkcontents.so in use on the client? If so it's a known
    >> problem: mmap() screws up the page cache invalidation routine
    >> invalidate_inode_page(). If you do the untar on the client,
    >> then all will be fine...

     > Hah! Yeah, you're right; both times it happened because mozilla
     > was running at the time. I can't have it untarred on the client
     > because the client isn't on every day. It's a minor nuisance
     > now that I've understood it.

     > Is there a fix in the works for this?

There are workarounds, but Linus isn't particular happy with
them. It's therefore unfortunately still work in progress...

Cheers,
   Trond
