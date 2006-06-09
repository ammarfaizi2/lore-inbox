Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbWFITuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbWFITuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWFITuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:50:22 -0400
Received: from thunk.org ([69.25.196.29]:27822 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030219AbWFITuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:50:21 -0400
Date: Fri, 9 Jun 2006 15:49:59 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Garzik <jeff@garzik.org>
Cc: Matthew Frost <artusemrys@sbcglobal.net>, Alex Tomas <alex@clusterfs.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609194959.GC10524@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>,
	Matthew Frost <artusemrys@sbcglobal.net>,
	Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net> <44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net> <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4489C34B.1080806@garzik.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 02:51:55PM -0400, Jeff Garzik wrote:
> ext3 is already essentially xiafs-on-life-support, when you consider 
> today's large storage systems and today's filesystem technology.  Just 
> look at the ugly hacks needed to support expanding an ext3 filesystem 
> online.

And what ugly hacks are you talking about?  It's actually quite clean;
with the latest e2fsprogs, you use the same command (resize2fs) for
doing both online and offline resizing.

						- Ted
