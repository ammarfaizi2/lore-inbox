Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbUKEEld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbUKEEld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 23:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbUKEEld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 23:41:33 -0500
Received: from ozlabs.org ([203.10.76.45]:54687 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262595AbUKEElU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 23:41:20 -0500
Date: Fri, 5 Nov 2004 15:38:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, jgarzik@mandrakesoft.com,
       orinoco-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Cosmetic updates for orinoco driver
Message-ID: <20041105043853.GB27883@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, jgarzik@mandrakesoft.com,
	orinoco-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20041103022444.GA14267@zax> <20041103154407.4d9833ca.akpm@osdl.org> <20041104021228.GA3949@zax> <418AE97A.9040003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418AE97A.9040003@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 09:46:18PM -0500, Jeff Garzik wrote:
> David Gibson wrote:
> >Ah, looks like Al Viro did the ioread/iowrite conversion while I
> >wasn't looking.  Ok, with that netdev patch I should be able to fix
> >things up (and merge the iowrite conversion back into CVS).
> 
> OK, I guess I will wait for an update.  What should I do with "Another 
> trivial orinoco update", which looks OK to me?

Go ahead and push it, if it looks ok to you.  I checked beforehand
that it commutes with the printk-and-so-forth patch.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
