Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293288AbSCJVX4>; Sun, 10 Mar 2002 16:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293283AbSCJVXq>; Sun, 10 Mar 2002 16:23:46 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:58377 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293277AbSCJVXi>;
	Sun, 10 Mar 2002 16:23:38 -0500
Date: Sun, 10 Mar 2002 18:23:18 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rob Turk <r.turk@chello.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <E16kAxQ-0007MV-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44L.0203101822490.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2002, Alan Cox wrote:
> > It was fabulous at that time. The first time you create a file, it gets ";1"
> > appended to it's filename. When you edit it, it gets saved under the same name,
> > this time appended by ";2". Edit it again... whell, you get the picture.
> > Cleaning up was as simple as "$ PURGE /KEEP=3" to keep the last three versions.
> >
> > For these days with sometimes hundreds of files, it might become confusing when
> > 'ls' shows all versions of all files, but back then it worked well.
>
> Its trickier than that - because all your other semantics have to align,
> its akin to the undelete problem (in fact its identical). Do you version
> on a rewrite, on a truncate, only on an O_CREAT ?

That's a nice question.  I would dread the scenario where a
new version was created for each append ;))

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

