Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWIDN3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWIDN3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWIDN3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:29:46 -0400
Received: from cs.columbia.edu ([128.59.16.20]:14823 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S1751349AbWIDN3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:29:44 -0400
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification
	Filesystem
From: Shaya Potter <spotter@cs.columbia.edu>
To: Pavel Machek <pavel@suse.cz>
Cc: Josef Sipek <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
In-Reply-To: <20060903110507.GD4884@ucw.cz>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	 <20060903110507.GD4884@ucw.cz>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 09:28:26 -0400
Message-Id: <1157376506.4398.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter2.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-03 at 11:05 +0000, Pavel Machek wrote:
> Hi!
> 
> > - Modifying a Unionfs branch directly, while the union is mounted, is
> >   currently unsupported.  Any such change may cause Unionfs to oops and it
> >   can even result in data loss!
> 
> I'm not sure if that is acceptable. Even root user should be unable to
> oops the kernel using 'normal' actions.

As I said in the other case.  imagine ext2/3 on a a san file system
where 2 systems try to make use of it.  Will they not have issues?

