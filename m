Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268591AbUHYUia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268591AbUHYUia (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268665AbUHYU3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:29:06 -0400
Received: from verein.lst.de ([213.95.11.210]:55234 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268609AbUHYUZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:25:47 -0400
Date: Wed, 25 Aug 2004 22:25:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825202539.GA17107@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825201929.GA16855@lst.de> <Pine.LNX.4.58.0408251323170.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408251323170.17766@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 01:24:36PM -0700, Linus Torvalds wrote:
> Now this I agree with, in the sense that I think that if we want to 
> support this, it should be supported at a VFS layer. 
> 
> On the other hand, I think doing it inside the filesystem with ugly hacks 
> is an acceptable way to prototype the idea before it's been proven to 
> really be workable. Maybe it has more problems with legacy apps than we'd 
> expect..

Oh, I'm the last person to tell anyone how to prototype things.  I just
don't want such inconsistancies in the mainline kernel.

