Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319356AbSHOBsE>; Wed, 14 Aug 2002 21:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319358AbSHOBsE>; Wed, 14 Aug 2002 21:48:04 -0400
Received: from mail.gurulabs.com ([208.177.141.7]:41647 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S319356AbSHOBsD>;
	Wed, 14 Aug 2002 21:48:03 -0400
Date: Wed, 14 Aug 2002 19:51:56 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Kendrick M. Smith" <kmsmith@umich.edu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "nfs@lists.sourceforge.net" <nfs@lists.sourceforge.net>,
       <beepy@netapp.com>, <trond.myklebust@fys.uio.no>,
       <torvalds@transmeta.com>
Subject: Re: Will NFSv4 be accepted?
In-Reply-To: <1029375327.28240.35.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208141938350.31203-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Q for Linus: What's the prospect of adding crypto to the kernel?

(more below)

On 15 Aug 2002, Alan Cox wrote:

> Ok item #1 you authenticate with the server and get a cryptographic key
> for use as credentials. This solves the bad client problem. Kerberos,
> gssapi etc will do the job

Right, I do understand that Kerberized/GSS NFS is not exclusive to NFSv4.  
However, right now, there is only one way to get Kerberized NFS. The CITI
NFSv4 patches.

Those patches are, in their estimation, ready for inclusion.  NFSv3 
support is "coming down the pipeline". 

I would rather see Kerberos V5 NFS data integrity and privacy support
first (also in the pipeline).  What the current status of including crypto
in the kernel?

> Item #2 is a bug in our NFS page cache handling. Its not legal in NFS to
> assume we can share caches between processes unless they have the same
> NFS credentials for the query. 

I wasn't aware of this.

Thanks,
Dax

