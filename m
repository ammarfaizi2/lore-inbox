Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316758AbSERGNf>; Sat, 18 May 2002 02:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSERGNe>; Sat, 18 May 2002 02:13:34 -0400
Received: from dsl-213-023-043-065.arcor-ip.net ([213.23.43.65]:45706 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316753AbSERGNd>;
	Sat, 18 May 2002 02:13:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Htree directory index for Ext2, updated
Date: Sat, 18 May 2002 08:13:16 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <200205170736.g4H7aNj281162@saturn.cs.uml.edu> <E178x1B-0000DW-00@starship> <20020518055808.GH21295@turbolinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E178xSu-0000Dc-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 May 2002 07:58, Andreas Dilger wrote:
> On May 18, 2002  07:44 +0200, Daniel Phillips wrote:
> > Funny you should mention that, since Bitkeeper has embarrassed itself pretty
> > badly with respect to patches, so far.
> > 
> >   - Somebody decided to add another level on top of the linux root directory
> >     in their source directory.  I can't import patches into that.
> 
> Hmm, I'm not sure what you are referring to here.

I cloned a repository that is arranged like:

  somedir
    |
    |--linux
    |    |
    |    The usual stuff
    |
     `---other things

Bitkeeper wants the destination for the import to be 'somedir', and cannot figure
out how to apply a patch that looks like, +++ src/include/linux/someheader.h, for
instance.

-- 
Daniel
