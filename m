Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268511AbUH3QCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268511AbUH3QCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 12:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268520AbUH3QCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 12:02:13 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:15323 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268511AbUH3QCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 12:02:06 -0400
Date: Mon, 30 Aug 2004 18:02:05 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Hans Reiser <reiser@namesys.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       flx@msu.ru, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
Message-ID: <20040830160205.GA7718@MAIL.13thfloor.at>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
	flx@msu.ru, Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, flx@namesys.com,
	reiserfs-list@namesys.com
References: <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <20040828105929.GB6746@alias> <Pine.LNX.4.58.0408281011280.2295@ppc970.osdl.org> <20040828190350.GA14152@alias> <20040828190901.GA18083@lst.de> <4130FBF8.8070005@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4130FBF8.8070005@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 02:41:12PM -0700, Hans Reiser wrote:
> I think it is reasonable to make the -nopseudos (turns off the metafiles 
> ) mount option mandatory, until the bugs are resolved.
> 
> Our testing did not find these metafile/VFS bugs because of the reason 
> for all our bugs, we screwed up. 
> 
> There is a distinct difference between some persons and I, which is that 
> some think all of reiser4 should be excluded until metafiles are 
> implemented by VFS some long time from now, and I, in that I merely 
> think buggy optional features should be turned off until they are 
> fixed.  I, being renowned for my paranoia and asininity as I am, think 
> these persons find it convenient as an excuse to keep us from competing, 
> and I think that if we were slower there would be less hassle every time 
> we try to get into the kernel. 
> 
> While reiser4 has some significant roughnesses remaining in its 
> performance, I think the average user would find it performs better than 
> other filesystems, and is stable enough for, say, a laptop, and I 
> predict that by the time we have it stable enough for mission critical 
> servers, all the roughness in various important corner cases will be 
> gone.  
> 
> Persons benchmarking it with tarballs, please be sure to use tarballs 
> created on reiser4, not ext2 tarballs, readdir order matters a lot for 
> sorted directory filesystems.

hmm, so probably we have to wait until all
tar packagers moved to reiser4, so that the
available tar files are 'sorted properly' ...

best,
Herbert

> Hans
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
