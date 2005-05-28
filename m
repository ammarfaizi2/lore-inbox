Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbVE1Kwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVE1Kwy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 06:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVE1Kwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 06:52:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51848 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262688AbVE1Kwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 06:52:50 -0400
Date: Sat, 28 May 2005 11:52:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: FUSE inclusion?
Message-ID: <20050528105249.GB20488@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <E1DbGol-0006tE-00@dorka.pomaz.szeredi.hu> <20050528102559.GA20153@infradead.org> <E1DbyoI-00088C-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DbyoI-00088C-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2005 at 12:44:54PM +0200, Miklos Szeredi wrote:
> > > So, if anybody still got a problem with the current version (as in -mm
> > > or released as 2.3-rc1 on SF.net), please speak up now.
> > 
> > FUSE_ALLOW_OTHER and FUSE_DEFAULT_PERMISSIONS are still there, and off by
> > default.
> 
> Yes.  The difference between last time lays in the details of the
> implementation, which is now well documented in
> Documentation/filesystems/fuse.txt, and to which everybody has agreed
> to.  Or am I mistaken?  Do you have any specific objection to the
> security measures layed out in there?

Just because it's documented it's not any better.  It's still the horrible
hack it was at the beginning and no amount of discussion or documentation
will change that.

