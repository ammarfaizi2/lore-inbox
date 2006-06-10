Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWFJBan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWFJBan (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 21:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWFJBan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 21:30:43 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:43931 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932073AbWFJBam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 21:30:42 -0400
Date: Fri, 9 Jun 2006 19:30:48 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Theodore Tso <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Matthew Frost <artusemrys@sbcglobal.net>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610013048.GS5964@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Theodore Tso <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Matthew Frost <artusemrys@sbcglobal.net>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
	linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
References: <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org> <20060609194959.GC10524@thunk.org> <4489D44A.1080700@garzik.org> <1149886670.5776.111.camel@sisko.sctweedie.blueyonder.co.uk> <4489ECDD.9060307@garzik.org> <1149890138.5776.114.camel@sisko.sctweedie.blueyonder.co.uk> <448A07EC.6000409@garzik.org> <20060610004727.GC7749@thunk.org> <448A1BBA.1030103@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448A1BBA.1030103@garzik.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  21:09 -0400, Jeff Garzik wrote:
> Theodore Tso wrote:
> > Jeff, you seem to think that the fact that the layout isn't precisely
> > the same after an on-line resizing is proof of something horrible, but
> > it isn't.  The exact location of filesystem metadata has never been
> > fixed, not in the past ten years of ext2/3 history, and this is not a
> > big deal.  It certainly isn't "proof" of on-line resizing being
> > something horrible, as you keep trying to claim, without any arguments
> > other than, "The layout is different!".  
> 
> No, I was proving merely that it is _different_.  And the values where 
> you see a _difference_ are the ones of which are no longer sized 
> optimally, after you grow the fs to a larger size.

It sounds like you don't know what you are talking about, which is OK,
except that you keep harping on some non-existent point.

> So you incur a performance penalty for resizing to size S2, rather than 
> mke2fs'ing the new blkdev at size S2.  Certainly within the confines of 
> ext3 that cannot be helped, but a different inode allocation strategy 
> could improve upon that.

???  Can you please be specific in what the performance penalty is, and
what specifically is "not sized optimally" after a resize?  How exactly
does inode allocation strategy relate to anything at all to online resizing.

Given that Ted and I are both disagreeing with you, and we are the two
people who know the most about the online resizing code (SCT is also
in this same group), maybe you should just concede that you are incorrect
on this point and move on.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

