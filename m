Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277528AbRJJXbS>; Wed, 10 Oct 2001 19:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277529AbRJJXbI>; Wed, 10 Oct 2001 19:31:08 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:50415 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277528AbRJJXav>; Wed, 10 Oct 2001 19:30:51 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 10 Oct 2001 17:28:32 -0600
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Concerned Programmer <tkhoadfdsaf@hotmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Alexander Viro <viro@math.psu.edu>, Keith Owens <kaos@ocs.com.au>,
        "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Tainted Modules Help Notices
Message-ID: <20011010172832.P10443@turbolinux.com>
Mail-Followup-To: Juan Quintela <quintela@mandrakesoft.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Concerned Programmer <tkhoadfdsaf@hotmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Alexander Viro <viro@math.psu.edu>, Keith Owens <kaos@ocs.com.au>,
	"Morgan Collins [Ax0n]" <sirmorcant@morcant.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15rQjC-0000m2-00@the-village.bc.nu> <m2itdnf6a9.fsf@anano.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2itdnf6a9.fsf@anano.mitica>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 11, 2001  01:02 +0200, Juan Quintela wrote:
> >>>>> "alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> alan> Well under the DMCA thats probably a criminal offence with five years in
> alan> jail. The truth however is that if you want to lie about licensing or
> alan> run a modutils that doesn't do it nobody stops you. Its there primarily
> alan> to deal with bug filtering from people who don't know better. Folks who
> alan> know enough to subvert the mechanism generally also know better than to
> alan> post Nvdriver bugs to l/k.
> 
> Never understimate the ability of users to subert that kind of
> barriers.

Given that "subversion" will only mean editing the text output of ksymoops
to not display the "tainted" flag, I don't see it to be a big barrier to
entry.  If it is in the FAQ (or documented elsewhere) that "if ksymoops
says 'tainted: 1' submit your bug reports only to the vendor" it will be
a small matter to delete that line, and if this is NOT documented anywhere
it will not reduce the number of bug submissions, which was the original
goal.

I don't think we need to be mucking with "GPL vs. BSD" or anything, but
rather "source available or not" as the criterion for a tainted module.
Heaven forbid that using some driver currently in the kernel sources
marks your kernel as tainted, it would make the whole thing useless.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

