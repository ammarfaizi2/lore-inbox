Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVALQQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVALQQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 11:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVALQQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 11:16:55 -0500
Received: from intake1.pliva.hr ([195.29.208.103]:4744 "EHLO intake1.pliva.hr")
	by vger.kernel.org with ESMTP id S261178AbVALQQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 11:16:53 -0500
Date: Wed, 12 Jan 2005 17:16:45 +0100
From: Dobrica Pavlinusic <dpavlin@rot13.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       mnalis@voyager.hr
Subject: Re: [fuse-devel] Merging?
Message-ID: <20050112161645.GA7162@llin.pliva.hr>
References: <loom.20041231T155940-548@post.gmane.org> <E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu> <E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu> <20050112153131.1f778264.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050112153131.1f778264.diegocg@gmail.com>
User-Agent: Mutt/1.5.6+20040907i
X-Spam-DCC: SPAMCHECK.NET: dmz3 1168; Body=1 Fuz1=1 Fuz2=1
X-Spam-Report: *  2.4 IN_REP_TO 'In-Reply-To' line found
	* -0.1 SUBJ_ENDS_IN_Q_MARK Subject: ends in a question mark
	* -3.3 ALL_TRUSTED Did not pass through any untrusted hosts
	* -7.0 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 03:31:31PM +0100, Diego Calleja wrote:
> El Wed, 12 Jan 2005 14:49:35 +0100 Miklos Szeredi <miklos@szeredi.hu> escribió:
> > Well, there doesn't seem to be a great rush to include FUSE in the
> > kernel.  Maybe they just don't realize what they are missing out on ;)
> >
> > So if any of you would like to support this motion, you can mail the
> > linux-kernel list and maybe Linus and Andrew, to generate a little
> > discussion on why (or why not) inclusion is a good idea.
> 
> -Possibility to write stupid filesystems like "gmailfs".

Not to mention Fuse::DBI which allows you to mount relational database
as a file-system. Imagine editing templates from your CMS with vi. Joy,
right?

Back to serious notes, having ability to write filesystems in user-space
is something that micro kernels (like HURD or plan9) had for a long time
and it's extremely useful if file-system semantic is mappable to problem
at hand.

That would also help reduce kernel bloat because you could write
something like umsdos in user-space where it belongs in first place.

-- 
Dobrica Pavlinusic               2share!2flame            dpavlin@rot13.org
Unix addict. Internet consultant.             http://www.rot13.org/~dpavlin

