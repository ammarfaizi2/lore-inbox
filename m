Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWEMQVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWEMQVM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 12:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWEMQVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 12:21:12 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:46087 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932470AbWEMQVL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 12:21:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pvNV1b2ynGRdOM06Kzpb1hDyYuICGpN5aNhoJUz8p5UyMUNC18bTpp7/xz3X0TNdU5JPTehyPjZfkGiJoWl8UKxyyL52cPTIwSDzykmkt7iI+ZuPKfIf81rS3NU9hj2HLxZeAD2w+7AG+lLhvbxwNcGBjboV7amWUVskL1NJcgQ=
Message-ID: <afcef88a0605130921k7139da13k1b7232acb29140c1@mail.gmail.com>
Date: Sat, 13 May 2006 11:21:10 -0500
From: "Michael Thompson" <michael.craig.thompson@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
Cc: "Phillip Hellewell" <phillip@hellewell.homeip.net>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, "James Morris" <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, "Erez Zadok" <ezk@cs.sunysb.edu>,
       "David Howells" <dhowells@redhat.com>
In-Reply-To: <44655ECD.10404@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060513033742.GA18598@hellewell.homeip.net>
	 <44655ECD.10404@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Phillip Hellewell wrote:
> > This patch set constitutes the 0.1.7 release of the eCryptfs
> > cryptographic filesystem:
> >
> > http://ecryptfs.sourceforge.net/
> >
> > It includes numerous updates based on comments on the 0.1.6 submission
> > made on May 4th. The only functional change worth noting is the
> > removal of the unnecessary second read in ecryptfs_get1page() and
> > ecryptfs_do_readpage().
> >
> > This patch set was produced and tested against the 2.6.17-rc3-mm1
> > release of the kernel.
>
> BTW.  I'm not sure if linux-fsdevel has different conventions; however
> usually you don't break up a patch according to files, but logical
> components or transformations from one "sane" kernel tree to the next.
> And that means things keep compiling and working.

The files themselves are broken down into logical components, so the
per-file patch approach seems reasonable to me.

> Sometimes big patches are justified.

This patch format (a whole repost) was requested.

Thanks,
Mike

-- 
Michael C. Thompson <mcthomps@us.ibm.com>
Software-Engineer, IBM LTC Security
