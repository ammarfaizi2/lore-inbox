Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136999AbREKAFk>; Thu, 10 May 2001 20:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137000AbREKAFb>; Thu, 10 May 2001 20:05:31 -0400
Received: from p3EE3CA1A.dip.t-dialin.net ([62.227.202.26]:19723 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S136999AbREKAFQ>; Thu, 10 May 2001 20:05:16 -0400
Date: Fri, 11 May 2001 01:37:26 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
Message-ID: <20010511013726.C31966@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01050910381407.26653@bugs> <20010510134453.A6816@emma1.emma.line.org> <3AFA9AD8.7080203@magenta-netlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFA9AD8.7080203@magenta-netlogic.com>; from tmh@magenta-netlogic.com on Thu, May 10, 2001 at 14:42:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2001, Tony Hoyle wrote:

> Hmm... Reiserfs is incompatible with knfsd?  That might explain the 
> massive data loss I was getting with reiserfs (basically I'd have to 
> reformat and reinstall every couple of weeks).  The machine this was 
> happening with also exports my apt cache for the rest of the network.

You're not getting data loss, but access denied, when hitting
incompatibilities, and it looks like it hits 2.2 hard while 2.4 is less
of a problem. Please search the reiserfs list archives for details.
vs-13048 is a good search term, I believe.
