Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135826AbRDTIYv>; Fri, 20 Apr 2001 04:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135827AbRDTIYm>; Fri, 20 Apr 2001 04:24:42 -0400
Received: from t2.redhat.com ([199.183.24.243]:5620 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135826AbRDTIYb>; Fri, 20 Apr 2001 04:24:31 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.GSO.4.05.10104192201330.8316-100000@pipt.oz.cc.utah.edu> 
In-Reply-To: <Pine.GSO.4.05.10104192201330.8316-100000@pipt.oz.cc.utah.edu> 
To: james rich <james.rich@m.cc.utah.edu>
Cc: Matthew Wilcox <willy@ldl.fc.hp.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: OK, let's try cleaning up another nit. Is anyone paying attention? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 Apr 2001 09:19:53 +0100
Message-ID: <14608.987754793@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


james.rich@m.cc.utah.edu said:
>  Doesn't this seem a little like the problems occurring with lvm right
> now? A separate tree maintained with the maintainers not wanting
> others submitting patches that conflict with their particular tree?
> It seems that any project should be able to submit any patch against
> The One True Tree: Linus' tree. 

Of course they can. Linus does apply them too. People are asking nicely 
that ESR not do so in this case, because merges are being planned. 

The contents of drivers/mtd/ are in the same situation. For some reason, I
felt it inappropriate to give every patch at every stage of development to
Linus for inclusion in the 2.4.0-test and 2.4.[123] kernels. Now I'm vaguely
happy with it all and it's stable, I'm working on cleaning up some of the 
cosmetics and breaking it up into digestible patches.

Doing primary development in CVS seems to work OK for me, and allows me to 
continue development without destabilising the One True Tree. During such 
times, it's useful to have a branch for the code which is in the One True 
Tree, so urgent fixes can be merged, and the diff against the One True Tree 
after each release has something to diff against to catch patches where 
people didn't even bother to Cc the maintainer.

I believe people were _told_ to hold off until 2.4.5-ish, or when the tree
became stable. Violent imagery was used to reinforce this instruction.
That being the case, how about holding the config changes back until after 
everyone else who's been waiting has merged their pending changes?

--
dwmw2


