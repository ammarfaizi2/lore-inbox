Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268111AbUIBRun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268111AbUIBRun (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 13:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268064AbUIBRsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 13:48:25 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52450 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268111AbUIBRrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 13:47:51 -0400
Subject: Re: silent semantic changes with reiser4
From: Lee Revell <rlrevell@joe-job.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Jamie Lokier <jamie@shareable.org>, Pavel Machek <pavel@suse.cz>,
       David Masover <ninja@slaphack.com>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl>
References: <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Message-Id: <1094147268.11364.48.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 13:47:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 10:25, Horst von Brand wrote:
> Lee Revell <rlrevell@joe-job.com> said:
> 
> [...]
> 
> > FWIW, this is how Windows does it now.  As of XP, 'Find files' has an
> > option, enabled by default, to look inside archives.  If you tell it to
> > look for a driver in a given directory it will also look inside .cab 
> > and .zip files.  It's extremely useful, I would imagine someone who uses
> > XP a lot will come to expect this feature.
> 
> It is trivial to implement this by looking inside the files. I.e., the way
> mc has done this for ages.

This requires a separate, MC-specific namespace.  The point is to unify
the namespace, not fragment it.

If Hans had a comprehensible web page, maybe more people would
understand this aspect of his argument.  Would you put digressions about
chaos theory and King Arthur in a man page?

Lee

