Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281450AbRLUMrT>; Fri, 21 Dec 2001 07:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281221AbRLUMrK>; Fri, 21 Dec 2001 07:47:10 -0500
Received: from pat.uio.no ([129.240.130.16]:33769 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S281129AbRLUMrF>;
	Fri, 21 Dec 2001 07:47:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo
To: GOTO Masanori <gotom@debian.or.jp>, davej@codemonkey.org.uk, davej@suse.de,
        linux-kernel@vger.kernel.org, andrea@suse.de, cel@monkey.org
Subject: Re: Possible O_DIRECT problems ?
Date: Fri, 21 Dec 2001 13:46:53 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011221000806.A26849@suse.de> <20011221003942.B26268@codemonkey.org.uk> <w53ellp2out.wl@megaela.fe.dis.titech.ac.jp>
In-Reply-To: <w53ellp2out.wl@megaela.fe.dis.titech.ac.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16HP4f-0001di-00@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21. December 2001 05:12, GOTO Masanori wrote:
> At Fri, 21 Dec 2001 00:39:42 +0000,
>
> Dave Jones <davej@codemonkey.org.uk> wrote:
> > On Fri, Dec 21, 2001 at 01:23:45AM +0100, Trond Myklebust wrote:
> >  >    O_DIRECT for NFS isn't yet merged into the kernel. Are these Chuck
> >  > Lever's NFS patches you've been testing?
>
> Where is Chuck's patch ? I searched but didn't find.

I haven't put it up on my own web-site, but it should be available from the 
CITI NFS client performance project site. See

   http://www.citi.umich.edu/projects/nfs-perf/patches/

> Supporting direct_IO with NFS is some meaningful
> for users who have fast NAS server environment, IMHO.

It can also provide for better data security in some circumstances. 
Journaling in databases over NFS can for instance benefit greatly, and has 
been one of Chuck's motivations for doing it.

Cheers,
   Trond
