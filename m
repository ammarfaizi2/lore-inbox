Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130090AbRAZTsJ>; Fri, 26 Jan 2001 14:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130092AbRAZTr7>; Fri, 26 Jan 2001 14:47:59 -0500
Received: from smtp-rt-6.wanadoo.fr ([193.252.19.160]:51705 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130090AbRAZTrw>; Fri, 26 Jan 2001 14:47:52 -0500
Date: Fri, 26 Jan 2001 20:45:31 +0100
From: patrick.mourlhon@wanadoo.fr
To: Rob Kaper <cap@capsi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Renaming lost+found
Message-ID: <20010126204531.A14179@MourOnLine.dnsalias.org>
Reply-To: patrick.mourlhon@wanadoo.fr
In-Reply-To: <20010126141350.Q6979@capsi.com> <200101261924.f0QJOWH15609@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101261924.f0QJOWH15609@webber.adilger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


An other maybe too obvious way, could be to :

alias ls='ls | grep -v "lost+found"'

if you are really annoyed by this tiny thing, which is  
IMHO, really the least thing i could be annoyed
of...
This took part on Unix file system design, from the
old days, as mentioned earlier by others.
Also think, that you might be happy the day, it will
be usefull... ;-)

Regards,

Patrick

On Fri, 26 Jan 2001, Andreas Dilger wrote:

> Rob Kaper writes:
> > Is there a way to rename lost+found ?? It bothers me to see it in ls all the
> > time because 99.9% of my time it's just useless and I really think
> > .lost+found (a hidden file) would make much more sense for daily use. I
> > assume this would require some ext2 changes as well as a patch to e2fsck
> > etc. (with backwards compatibility of course)
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
