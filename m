Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285110AbSADWRP>; Fri, 4 Jan 2002 17:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285074AbSADWRG>; Fri, 4 Jan 2002 17:17:06 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:65021 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S285093AbSADWQR>;
	Fri, 4 Jan 2002 17:16:17 -0500
Date: Fri, 4 Jan 2002 15:15:13 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: Andries.Brouwer@cwi.nl, acme@conectiva.com.br, ion@cs.columbia.edu,
        linux-fsdevel@vger.kernel.org, linux-fsdevel-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org, phillips@bonn-fries.net
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Message-ID: <20020104151513.Y12868@lynx.no>
Mail-Followup-To: Bryan Henderson <hbryan@us.ibm.com>,
	Andries.Brouwer@cwi.nl, acme@conectiva.com.br, ion@cs.columbia.edu,
	linux-fsdevel@vger.kernel.org, linux-fsdevel-owner@vger.kernel.org,
	linux-kernel@vger.kernel.org, phillips@bonn-fries.net
In-Reply-To: <OF2FE44987.D9D207BC-ON87256B37.005AB446@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <OF2FE44987.D9D207BC-ON87256B37.005AB446@boulder.ibm.com>; from hbryan@us.ibm.com on Fri, Jan 04, 2002 at 09:45:04AM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 04, 2002  09:45 -0700, Bryan Henderson wrote:
> >>    sizeof (foo): 1611, sizeof(foo): 19364 => -bs should be removed
> >> ...
> >>    int
> >>    foo(int x): 11408, int foo(int x): 57275 => -psl should be removed
> >
> >I do not think good style is best defined by majority vote.
> 
> I don't think the implication was that sizeof(foo) is better style because
> more people like it.  The implication is that consistency is, in general,
> good programming style and it's easier to arrive at consistency by adhering
> to the majority style than by adhering to the minority style.

That was my goal.

> And I don't see what any of this has to do with whether an option should be
> removed from Lindent.  Lindent should be a tool, which means it helps a
> user do whatever he wants to do.  Whether he should want to do "sizeof
> (foo)" is a separate issue.

Well Lindent != indent.  The "indent" program can do formatting to the
wishes of the user.  However, "Lindent" is a wrapper script which is
trying to impose the will of Linus on other kernel programmers, and as
such "what the user wants to do" is of no concern.  If they don't want
to follow the "mandated" coding style, then they just don't use Lindent.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

