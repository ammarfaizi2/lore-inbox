Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290685AbSBFR1c>; Wed, 6 Feb 2002 12:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290687AbSBFR1W>; Wed, 6 Feb 2002 12:27:22 -0500
Received: from dns.logatique.fr ([213.41.101.1]:1007 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S290685AbSBFR1E>; Wed, 6 Feb 2002 12:27:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Capricelli <tcaprice@logatique.fr>
To: Ville Herva <vherva@niksula.hut.fi>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: How to check the kernel compile options ?
Date: Wed, 6 Feb 2002 18:26:37 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3ofj2galz.fsf@linux.local> <E16YSs7-0005GY-00@the-village.bc.nu> <20020206162657.GD534915@niksula.cs.hut.fi>
In-Reply-To: <20020206162657.GD534915@niksula.cs.hut.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020206172423.3967123CD3@persephone.dmz.logatique.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> What is even harder to find out given a binary kernel is which patches (if
> any) have been applied to it. What if there was one file (say,
> /usr/src/linux/patches) to which each (well-behaved) patch would append a
> line or two (patch name, version, author, url), and then you could later
> extract that information the same way you extract .config?

	I second that. It would be great to have a way of knowing what's different 
from vanillia kernel. though:

	* we can't expect each patch to do the 'magic thing'. But at least, those 
big patches lying around could follow this kind of rule. I don't care about 
typos patches, but It would be great to know that (for ex.) the rmap patch is 
there or not.

	* having /usr/src/linux/patches is not practical : it will be a big mess wrt 
to conflict

	The reason why I have not proposed something already is that I have no clue 
how to achieve this purpose. But I still would like to have a way to know 
which big patches have been in my kernel.


sorry,
Thomas
