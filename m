Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSHBRVn>; Fri, 2 Aug 2002 13:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSHBRVn>; Fri, 2 Aug 2002 13:21:43 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:33796 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S316599AbSHBRVm>; Fri, 2 Aug 2002 13:21:42 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15690.49267.930478.333263@laputa.namesys.com>
Date: Fri, 2 Aug 2002 21:25:07 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Hans Reiser <reiser@namesys.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Steve Lord <lord@sgi.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Alexander Viro <viro@math.psu.edu>,
       "Peter J. Braam" <braam@clusterfs.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BIG files & file systems
In-Reply-To: <3D4ABAE7.6000709@namesys.com>
References: <20020731210739.GA15492@ravel.coda.cs.cmu.edu>
	<Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu>
	<20020801035119.GA21769@ravel.coda.cs.cmu.edu>
	<1028246981.11223.56.camel@snafu>
	<20020802135620.GA29534@ravel.coda.cs.cmu.edu>
	<1028297194.30192.25.camel@jen.americas.sgi.com>
	<3D4AA0E6.9000904@namesys.com>
	<shslm7pclrx.fsf@charged.uio.no>
	<3D4ABAE7.6000709@namesys.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Meat: Chicken Fried Steak
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:
 > Trond Myklebust wrote:
 > 
 > >     > 4 billion files is not enough to store the government's XML
 > >     > databases in.
 > >
 > >That's more of a glibc-specific bug. Most other libc implementations
 > >appear to be quite capable of providing a userspace 'readdir()' which
 > >doesn't ever use the lseek() syscall.
 > >
 > Interesting.  Thanks for the info.

But there still is a problem with applications (if any) calling
seekdir/telldir directly...

 > 
 > -- 
 > Hans
 > 

Nikita.

 > 
