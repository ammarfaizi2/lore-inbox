Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316756AbSERGXP>; Sat, 18 May 2002 02:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSERGXO>; Sat, 18 May 2002 02:23:14 -0400
Received: from dsl-213-023-043-065.arcor-ip.net ([213.23.43.65]:51850 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316756AbSERGXO>;
	Sat, 18 May 2002 02:23:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Htree directory index for Ext2, updated
Date: Sat, 18 May 2002 08:22:56 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <200205170736.g4H7aNj281162@saturn.cs.uml.edu> <E178x1B-0000DW-00@starship> <20020518055808.GH21295@turbolinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E178xcH-0000Dv-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 May 2002 07:58, Andreas Dilger wrote:
> On May 18, 2002  07:44 +0200, Daniel Phillips wrote:
> >   - I can apply patches to bitkeeper repository using the normal 'patch',
> >     but Bitkeeper gets its revenge later, as each bk edit command starts
> >     off by throwing away the patch.
> 
> This is also strange, as when I use patch to apply a patch to files not
> checked out, patch asks me if I should check them out in write mode
> (which I do, of course).
> 
> Of course, if you are using patch to apply changes to a BK tree it isn't
> really BK in the end.  What I was referring to was importing a changeset
> would probably get the target files correct 100% of the time, unlike the
> situation you are describing with patch.

The solution to this appears to be to apply the patch with -g1.  With -g0,
strange things happen, as described above.

-- 
Daniel
