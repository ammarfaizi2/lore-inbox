Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbRBBWHH>; Fri, 2 Feb 2001 17:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130194AbRBBWG5>; Fri, 2 Feb 2001 17:06:57 -0500
Received: from piawa7.pit.physik.uni-tuebingen.de ([134.2.74.1]:15498 "EHLO
	piawa7.pit.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S130180AbRBBWGq>; Fri, 2 Feb 2001 17:06:46 -0500
Date: Fri, 2 Feb 2001 23:06:20 +0100
From: Arthur Erhardt <erhardt@pit.physik.uni-tuebingen.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
Message-ID: <20010202230620.A13943@piawa7.pit.physik.uni-tuebingen.de>
In-Reply-To: <200102022122.f12LMct11509@moisil.dev.hydraweb.com> <E14OoD8-0007GI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14OoD8-0007GI-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 02, 2001 at 09:57:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2001 at 09:57:39PM +0000, Alan Cox wrote:
: > As it stands, there is no way to determine programatically whether
: > gcc-2.96 is broken or now. The only way to do it is to check the RPM
: > version -- which, needless to say, is a bit difficult to do from the
: > C code about to be compiled. So I can't really blame Hans if he decides
: > to outlaw gcc-2.96[.0] for reiserfs compiles.
: 
: Oh I can see why Hans wants to cut down his bug reporting load. I can also
: say from experience it wont work. If you put #error in then everyone will
: mail him and complain it doesnt build, if you put #warning in nobody will
: read it and if you dont put anything in you get the odd bug report anyway.
: 
: Basically you can't win and unfortunately a shrink wrap forcing the user
: to read the README file for the kernel violates the GPL ..

Alan, as a user (one of those few that actually read documentation), I
think it is a good idea to stop people from hurting their data by using
the wrong compiler and assuming everything is ok until shit happens. 

As you explained, one either gets the bug reports or the complaints 
that $SOURCE doesn't compile. The work for the developers might be 
about the same size, the impact on the users' side is less
destructive, though.

Arthur

-- 
arthur dot erhardt at pit dot physik dot uni dash tuebingen dot de 
*pgp key available*                                         dg7sea

A physicist is an atom's way of knowing about atoms.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
