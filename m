Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289598AbSAWAue>; Tue, 22 Jan 2002 19:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289600AbSAWAuX>; Tue, 22 Jan 2002 19:50:23 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:51999 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S289598AbSAWAuS>; Tue, 22 Jan 2002 19:50:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [OOPS] with 2.4.18-pre4+linux-2.4.18-NFS_ALL
Date: Wed, 23 Jan 2002 01:50:09 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020120164118.D587513E3@shrek.lisa.de> <20020120222722.3972B143F@shrek.lisa.de> <15435.20982.84353.824971@charged.uio.no>
In-Reply-To: <15435.20982.84353.824971@charged.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020123005010.14E071472@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 21. January 2002 00:25, Trond Myklebust wrote:
> >>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:
>      > On Sunday, 20. January 2002 19:03, Trond Myklebust wrote:
>     >> >>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:
>     >> >
>     >> > Hi Trond et al., I can reliably reproduce this oops on my
>     >> > diskless with NFS_ALL applied, but not with plain-pre4, just
>     >> > by quitting one of {StarOffice,VMware}.
>     >>
>     >> The new version should be rid of it. It was a call to
>     >> get_file() which was missing a test for a NULL argument.
>     >>
>      > Are you sure?
>
> I forgot the nfs_cred_file() in the line above. That too is fixed now,
> and so fsx is running fine again...

Would you like to give me a pointer to the famous fsx?

Just for the record, your actual NFS_ALL patch finally solved the problem(s), 
it introduced ;-)

Many thanks.

> Cheers,
>    Trond

Happy-NFS-ing-ly y'rs,
  Hans-Peter
