Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293634AbSCPBEn>; Fri, 15 Mar 2002 20:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293635AbSCPBEd>; Fri, 15 Mar 2002 20:04:33 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:31738 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S293634AbSCPBEX>; Fri, 15 Mar 2002 20:04:23 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 15 Mar 2002 18:02:36 -0700
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 and BitKeeper
Message-ID: <20020316010236.GB424@turbolinux.com>
Mail-Followup-To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020315111022.S29887@work.bitmover.com> <Pine.LNX.4.33.0203151110130.29289-100000@penguin.transmeta.com> <20020315113001.W29887@work.bitmover.com> <20020316013134.A31470@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020316013134.A31470@devcon.net>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 16, 2002  01:31 +0100, Andreas Ferber wrote:
> I'm certainly not a "vim genius", but somehow I managed to write some
> vim autocmds that do this ;-)
> 
> You can get the vim script from
> 
>     http://www.myipv6.de/vim/extensions/bk.vim
> 
> Simply source it from your .vimrc. I tested it with vim 6.0 only,
> although it should also work with prior versions.
> 
> On open, it tries to checkout a file from bitkeeper if it isn't
> already checked out (doing "bk get" if you open it readonly and "bk
> edit" otherwise), and it "bk edit"s the file if you start making
> changes to a readonly bitkeeper controlled file.
> 
> Unfortunately, vim doesn't trigger the FileChangedRO autocmd if you do
> a ":set readonly!" to go from readonly to read/write, so it doesn't
> handle this case (AFAIK there is no way to intercept this command).

Well, you shouldn't be going from read-write to readonly in this way
anyways, so I don't think it is a problem.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

