Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286256AbRLTNjO>; Thu, 20 Dec 2001 08:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286255AbRLTNjG>; Thu, 20 Dec 2001 08:39:06 -0500
Received: from mail48-s.fg.online.no ([148.122.161.48]:40617 "EHLO
	mail48.fg.online.no") by vger.kernel.org with ESMTP
	id <S286251AbRLTNi6>; Thu, 20 Dec 2001 08:38:58 -0500
Message-Id: <200112201338.OAA23947@mail48.fg.online.no>
Content-Type: text/plain; charset=US-ASCII
From: Svein Ove Aas <svein@crfh.dyndns.org>
Reply-To: svein.ove@aas.no
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: File copy system call proposal
Date: Thu, 20 Dec 2001 14:38:50 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200112100544.fBA5isV223458@saturn.cs.uml.edu> <E16GnIg-0000V5-00@starship.berlin> <20011220110936.A18142@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011220110936.A18142@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20. December 2001 11:09, Pavel Machek wrote:
>
> They need to get a clue. No need to work around their bugs in kernel.
>
> Anyway copyfile syscall would be nice for other reasons. (cp -a kernel
> tree then apply patch without waiting for physical copy to be done
> would be handy).
> 								Pavel

Never mind that it might save a great deal of space...
I often operate with three/more different kernel trees, but the differences 
are often trivial.
If the VFS created a COW node when I use cp -a I would, obviously, save a 
great deal of space; this goes for numerous other source trees too.

Now there's a real world example for you.

- Svein Ove Aas
