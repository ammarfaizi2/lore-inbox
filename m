Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVE1K0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVE1K0I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 06:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVE1K0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 06:26:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25736 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262682AbVE1K0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 06:26:00 -0400
Date: Sat, 28 May 2005 11:25:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: FUSE inclusion?
Message-ID: <20050528102559.GA20153@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <E1DbGol-0006tE-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DbGol-0006tE-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 01:46:27PM +0200, Miklos Szeredi wrote:
> As 2.6.12 draws near (hopefully), I'd like again to solicit people's
> opinion about inclusion of FUSE into mainline in the next cycle.
> 
> I'm asking now, and not when 2.6.12 is already released, because last
> time there was a big rush of reviews and complaints, and by the time
> things quieted down it was a bit too late.  Thanks to everybody
> involved BTW :)
> 
> So, if anybody still got a problem with the current version (as in -mm
> or released as 2.3-rc1 on SF.net), please speak up now.

FUSE_ALLOW_OTHER and FUSE_DEFAULT_PERMISSIONS are still there, and off by
default.

So the same NACK as last time.

Remove them and it's fine to go in.
