Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262438AbSJDQ1I>; Fri, 4 Oct 2002 12:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262428AbSJDQ1H>; Fri, 4 Oct 2002 12:27:07 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:19695 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262432AbSJDQ0g>; Fri, 4 Oct 2002 12:26:36 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 4 Oct 2002 10:30:01 -0600
To: David Howells <dhowells@cambridge.redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS filesystem for Linux (2/2)
Message-ID: <20021004163001.GV3000@clusterfs.com>
Mail-Followup-To: David Howells <dhowells@cambridge.redhat.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
References: <trond.myklebust@fys.uio.no> <shsheg2i7x2.fsf@charged.uio.no> <27308.1033745758@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27308.1033745758@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 04, 2002  16:35 +0100, David Howells wrote:
> 
> > NFSv4 does indeed require the full kerberos encryption stuff in the
> > kernel. The RFC specifies that krb5 support is a minimum requirement, and we
> > will expect to have that in 2.6 (or 3.0 or whatever it's called these
> > days...)
> 
> Might this be something I can make use of for my AFS filesystem too?

We will also need kerberos for Lustre when we start implementing
security.  We will be using the GSSAPI for security, so basically
the same as what AFS is using.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

