Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129637AbRBBV5l>; Fri, 2 Feb 2001 16:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129976AbRBBV5c>; Fri, 2 Feb 2001 16:57:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50440 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129637AbRBBV53>; Fri, 2 Feb 2001 16:57:29 -0500
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
To: ionut@moisil.cs.columbia.edu (Ion Badulescu)
Date: Fri, 2 Feb 2001 21:57:39 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), reiser@namesys.com (Hans Reiser),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        kas@informatics.muni.cz (Jan Kasprzak)
In-Reply-To: <200102022122.f12LMct11509@moisil.dev.hydraweb.com> from "Ion Badulescu" at Feb 02, 2001 01:22:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OoD8-0007GI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As it stands, there is no way to determine programatically whether
> gcc-2.96 is broken or now. The only way to do it is to check the RPM
> version -- which, needless to say, is a bit difficult to do from the
> C code about to be compiled. So I can't really blame Hans if he decides
> to outlaw gcc-2.96[.0] for reiserfs compiles.

Oh I can see why Hans wants to cut down his bug reporting load. I can also
say from experience it wont work. If you put #error in then everyone will
mail him and complain it doesnt build, if you put #warning in nobody will
read it and if you dont put anything in you get the odd bug report anyway.

Basically you can't win and unfortunately a shrink wrap forcing the user
to read the README file for the kernel violates the GPL ..

Jaded, me ?

Alan



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
