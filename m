Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287699AbSBMQ63>; Wed, 13 Feb 2002 11:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287840AbSBMQ6T>; Wed, 13 Feb 2002 11:58:19 -0500
Received: from [63.231.122.81] ([63.231.122.81]:35680 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S287699AbSBMQ6G>;
	Wed, 13 Feb 2002 11:58:06 -0500
Date: Wed, 13 Feb 2002 09:55:02 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
        Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020213095502.F25535@lynx.turbolabs.com>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>,
	Rob Landley <landley@trommello.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020212190834.W9826@lynx.turbolabs.com> <Pine.LNX.4.33.0202131300500.16151-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202131300500.16151-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Feb 13, 2002 at 01:07:11PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 13, 2002  13:07 +0100, Ingo Molnar wrote:
> On Tue, 12 Feb 2002, Andreas Dilger wrote:
> > Is this using "bk clone -l" or just "bk clone"?  I would _imagine_
> > that since the rmap changes are fairly localized that you would only
> > get multiple copies of a limited number of files, and it wouldn't
> > increase the size of each repository very much.
> 
> the problem is, i'd like to see all these changes in a single tree, and
> i'd like to be able to specify whether two changesets have semantic
> dependencies on each other or not.

Oh, I agree.  My response was only to Rik's mention that his multiple trees
take up too much space.  I would personally also want to be able to separate
independent changes out of my tree rather than having many repositories.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

