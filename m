Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135914AbREIIxa>; Wed, 9 May 2001 04:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135919AbREIIxT>; Wed, 9 May 2001 04:53:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41736 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135914AbREIIxL>; Wed, 9 May 2001 04:53:11 -0400
Subject: Re: bug in redhat gcc 2.96
To: jwright@penguincomputing.com
Date: Wed, 9 May 2001 09:56:24 +0100 (BST)
Cc: redhat-devel-list@redhat.com, linux-kernel@vger.kernel.org,
        jhogan@redhat.com (Jeremy Hogan), mikev@redhat.com (Mike Vaillancourt),
        ppokorny@penguincomputing.com (Philip Pokorny)
In-Reply-To: <Pine.LNX.4.33.0105081927320.1798-100000@foo.penguincomputing.com> from "Jim Wright" at May 08, 2001 08:05:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xPli-0001qP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As this is with Red Hat's version of gcc, I'm not sending
> this to the gcc folks.  RPMs of gcc with this problem

(If you have the time check 3.0 CVS doesnt show the same problem, the RH tree
 diverges from it so may well be unique in having the bug but many bugs are
 shared)

> include gcc-2.96-69 and gcc-2.96-81.  This has been logged
> as http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=39764.

Thanks.

> Any suggestions for a way to cope with this?  We have a
> customer who's system fails due to this.

You can build 2.4 quite sanely with egcs-1.1.2 (aka kgcc)

