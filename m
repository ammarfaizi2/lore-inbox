Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261252AbREMMl2>; Sun, 13 May 2001 08:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261403AbREMMlS>; Sun, 13 May 2001 08:41:18 -0400
Received: from stine.vestdata.no ([195.204.68.10]:14093 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S261252AbREMMlL>; Sun, 13 May 2001 08:41:11 -0400
Date: Sun, 13 May 2001 14:41:05 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: linux-kernel@vger.kernel.org
Subject: Re: undeleting files with from reiserfs
Message-ID: <20010513144105.A7466@vestdata.no>
In-Reply-To: <20010513033946.A32539@dandelion.darkorb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.5i
In-Reply-To: <20010513033946.A32539@dandelion.darkorb.net>; from Gabriel Rocha on Sun, May 13, 2001 at 03:39:46AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 03:39:46AM -0400, Gabriel Rocha wrote:
> ok, i screwed up and there went my 2 gigs of mp3's...i feel stupid, i
> figure, what the heck, i can take this as the perfect oportunity to
> leanr how to undelete stuff...lo and behold, i find tons of info on how
> to undelete from a ext2 filesystem...nothing on reiser...pointers on
> docs would be really appreciated, as would any help anyone  can give me.
> thanks. --gabe

Reiserfs dosn't support undelete.

However, there if you run reiserfsck with option --rebuild-tree, it will
rebuild the tree, and probably relink your deleted files. Read the
man-page and back up your partition first.

You can find reiserfsprogs-3.x.0j.tar.gz at ftp.namesys.com.


-- 
Ragnar Kjørstad
Big Storage
