Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129105AbRBBVXc>; Fri, 2 Feb 2001 16:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbRBBVXL>; Fri, 2 Feb 2001 16:23:11 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:51465 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129526AbRBBVXI>; Fri, 2 Feb 2001 16:23:08 -0500
Date: Fri, 2 Feb 2001 13:22:38 -0800
Message-Id: <200102022122.f12LMct11509@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), reiser@namesys.com (Hans Reiser),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        kas@informatics.muni.cz (Jan Kasprzak)
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
X-Newsgroups: cs.lists.linux-kernel
In-Reply-To: <cs.lists.linux-kernel/E14OjME-0006nU-00@the-village.bc.nu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001 16:46:45 +0000 (GMT), Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> : 	It is the original one. I'll try with the -69:
>> : 
>> 	With 2.96-69 the reiserfs seems to work well.
>> Sorry for the confusion, I forgot to upgrade the gcc on my machine.
> 
> Excellent. Im just glad to know its a fixed bug.

Yes. But since Red Hat took upon themselves to define "gcc 2.96", they
should have created a new patchlevel (2.96.1) for their fixed compiler.

As it stands, there is no way to determine programatically whether
gcc-2.96 is broken or now. The only way to do it is to check the RPM
version -- which, needless to say, is a bit difficult to do from the
C code about to be compiled. So I can't really blame Hans if he decides
to outlaw gcc-2.96[.0] for reiserfs compiles.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
