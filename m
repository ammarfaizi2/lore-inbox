Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312279AbSEXV6B>; Fri, 24 May 2002 17:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312381AbSEXV6A>; Fri, 24 May 2002 17:58:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25987 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312279AbSEXV57>;
	Fri, 24 May 2002 17:57:59 -0400
Date: Fri, 24 May 2002 14:43:05 -0700 (PDT)
Message-Id: <20020524.144305.88932392.davem@redhat.com>
To: xavier.bestel@free.fr
Cc: dent@cosy.sbg.ac.at, alan@lxorguk.ukuu.org.uk, tori@ringstrom.mine.nu,
        imipak@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: Linux crypto?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1022276970.4174.153.camel@bip>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Xavier Bestel <xavier.bestel@free.fr>
   Date: 24 May 2002 23:49:29 +0200
   
   Why ? You can make all edits you like, they just won't be folded back to
   their tree. You can retrieve all their fixes, just if you have an
   important change to do in their core, do it as free speech on their
   public mailing list, do not provide a patch.
   
I can't edit their code because effectively I could contaminate
their sources.

Say I make some global networking API change, and this required
a significant edit to ipsec to make it comply with the new
structure layout or whatever.

And let's assume there is only one clear way to implement the
change, no other way to do the change would make any sense at all.

So the IPSEC people would have to effectively avoid integrating my
change, ie. it is a big onus on them to make their version of the API
update different enough from my edits so that nobody can claim they
just applied my change.

And the fact that there would be two edits makes no sense.  If a
change has to occur twice in two different ways this makes merging a
disaster.

So someone quips "just let them edit and just merge from IPSEC" and
I say I refuse to let something just sit in the tree that I cannot
edit when I want to make sweeping changes across the tree.  That is
unacceptable.
