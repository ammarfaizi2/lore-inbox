Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265701AbSKASyM>; Fri, 1 Nov 2002 13:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265703AbSKASyM>; Fri, 1 Nov 2002 13:54:12 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:63668 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S265701AbSKASyL>; Fri, 1 Nov 2002 13:54:11 -0500
Date: Fri, 1 Nov 2002 11:00:23 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Davidsen <davidsen@tmr.com>, Linus Torvalds <torvalds@transmeta.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
Message-ID: <20021101190022.GB17573@nic1-pc.us.oracle.com>
References: <Pine.LNX.3.96.1021101012947.23822C-100000@gatekeeper.tmr.com> <1036157204.12693.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036157204.12693.13.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 01:26:44PM +0000, Alan Cox wrote:
> My concerns are solely with things like the correctness of the disk
> dumper. Its obviously a good way to do a lot more damage if it isnt done
> carefully.

	I always liked the AIX dumper choices.  You could either dump to
the swap area (and startup detects the dump and moves it to the
filesystem before swapon) or provide a dedicated dump partition.  The
latter was prefered.
	Either of these methods merely require the dumper to correctly
write to one disk partition.  This is about as simple as you are going
to get in disk dumping.

Joel

-- 

"You must remember this:
 A kiss is just a kiss,
 A sigh is just a sigh.
 The fundamental rules apply
 As time goes by."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
