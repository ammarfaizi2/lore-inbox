Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSHOGOz>; Thu, 15 Aug 2002 02:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319321AbSHOGOy>; Thu, 15 Aug 2002 02:14:54 -0400
Received: from citi.umich.edu ([141.211.92.141]:51334 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S316599AbSHOGOy>;
	Thu, 15 Aug 2002 02:14:54 -0400
Date: Thu, 15 Aug 2002 02:18:48 -0400
From: marius aamodt eriksen <marius@umich.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Pawlowski <beepy@netapp.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, dax@gurulabs.com,
       Linus Torvalds <torvalds@transmeta.com>, kmsmith@umich.edu,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: Will NFSv4 be accepted?
Message-ID: <20020815061848.GA9122@umich.edu>
Reply-To: marius@citi.umich.edu
References: <200208142234.g7EMYvQ21700@tooting-fe.eng> <1029373829.28240.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029373829.28240.16.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [020814 21:13]:

> On Wed, 2002-08-14 at 23:34, Brian Pawlowski wrote:
> > But ACL support over the wire is an argument for V4 - and fine grained
> > authorization coupled to strong authentication makes for a flexible 
> > security package.
> 
> ACL works in NFSv2 and nicely in NFSv3 - again the problems Linux has
> are the client failing to respect basic NFS rules of operation.

there is no over-the-wire specification for sending or receving ACLs
on NFSv{2,3} - hence the server may choose to obey them, but an
arbitrary client cannot set them, or view them.

marius.

-- 
> marius@umich.edu > http://www.citi.umich.edu/u/marius
