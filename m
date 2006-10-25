Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWJYVNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWJYVNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 17:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWJYVNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 17:13:52 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:47066 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1030345AbWJYVNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 17:13:50 -0400
Date: Wed, 25 Oct 2006 17:13:41 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: lkml@pengaru.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: rename() contention (BUG?)
Message-ID: <20061025211341.GB7128@filer.fsl.cs.sunysb.edu>
References: <20061025205634.GB9100@shells.gnugeneration.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025205634.GB9100@shells.gnugeneration.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 03:56:34PM -0500, lkml@pengaru.com wrote:
> Hello,
> 
> I have seen some scalability problems with Maildir-based mail systems running on
> Linux (debian sarge, 2.6.8), and after much investigation I found a large part
> of the problem was rename() contention.
 
Just FYI, around 2.6.15 the i_sem was replace with i_mutex which is much
better/faster. (And I would strongly suggest you upgrade.) I would actually
like to know how much the lock contention decresed for your case.

(I'm going to read the rest when I get back.)
 
Josef "Jeff" Sipek.

-- 
In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like
that.
		- Linus Torvalds
