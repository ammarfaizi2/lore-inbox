Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVCBW1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVCBW1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVCBWZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:25:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62890 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262499AbVCBWTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:19:10 -0500
Date: Wed, 2 Mar 2005 22:19:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [request for inclusion] Filesystem in Userspace
Message-ID: <20050302221901.GA26008@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <E1D6YPJ-0000Jv-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1D6YPJ-0000Jv-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 07:17:13PM +0100, Miklos Szeredi wrote:
> Hi Andrew!
> 
> Do you have any objections to merging FUSE in mainline kernel?
> 
> It's been in -mm for the 2.6.11 cycle, and the same code was released
> a month ago as FUSE-2.2.  So it should have received a fair amount of
> testing, with no problems found so far.
> 
> The one originally merged into -mm already addressed all major issues
> that people found (most importantly the OOM deadlock thing), and
> though there were some minor changes in the interface since then, I
> feel that the current kernel interface will stand up to the test of
> time.


Please give me or some other filesystem person some time to look over
it, there were a few things that looked really fishy.

And apologies for not having time to look at it earlier, but I'm a little
bit too busy right now.

