Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbUKQTU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUKQTU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUKQTSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:18:47 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:28167 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262460AbUKQTSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:18:05 -0500
Date: Wed, 17 Nov 2004 19:18:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@novell.com>
Cc: Christoph Hellwig <hch@infradead.org>, ttb@tentacle.dhs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify: vfs_permission was replaced
Message-ID: <20041117191803.GA11830@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@novell.com>, ttb@tentacle.dhs.org,
	linux-kernel@vger.kernel.org
References: <1100710677.6280.2.camel@betsy.boston.ximian.com> <1100714560.6280.7.camel@betsy.boston.ximian.com> <20041117190850.GA11682@infradead.org> <1100718601.4981.2.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100718601.4981.2.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 02:10:01PM -0500, Robert Love wrote:
> On Wed, 2004-11-17 at 19:08 +0000, Christoph Hellwig wrote:
> 
> > And using either of them was/is totally bogus.  It's a helper for filesystems,
> > not a general API.
> 
> Is there some specific reason you have a problem with its use?  It works
> quite nicely for what we need.

No it doesn't.  Please try to understand the APIs before you're using them.
Just looking at the callers should give you an immediate clue.
