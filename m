Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbUKUU4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbUKUU4T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 15:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUKUU4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 15:56:19 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:64264 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261789AbUKUU4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 15:56:18 -0500
Date: Sun, 21 Nov 2004 20:56:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>, Antonino Daplas <adaplas@pol.net>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] cyber2000fb.c: misc cleanups
Message-ID: <20041121205613.GA12634@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Antonino Daplas <adaplas@pol.net>,
	linux-kernel@vger.kernel.org,
	linux-fbdev-devel@lists.sourceforge.net
References: <20041121153614.GR2829@stusta.de> <20041121204752.A23300@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121204752.A23300@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 08:47:52PM +0000, Russell King wrote:
> On Sun, Nov 21, 2004 at 04:36:14PM +0100, Adrian Bunk wrote:
> > The patch below ncludes the following cleanups for 
> > drivers/video/cyber2000fb.c:
> > - remove five EXPORT_SYMBOL'ed but completely unused functions
> > - make some needlessly global code static
> 
> These are used by the video capture code which isn't merged, but is
> used by people.  Rejected.

If people use the code it should get merged or Adrian has all reasons to
remove or #if 0 the code.

