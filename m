Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268089AbUH1Vnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268089AbUH1Vnb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUH1VmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:42:10 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:51599 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268089AbUH1VlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:41:11 -0400
Message-ID: <4130FBF8.8070005@namesys.com>
Date: Sat, 28 Aug 2004 14:41:12 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Christoph Hellwig <hch@lst.de>, flx@msu.ru,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <20040828105929.GB6746@alias> <Pine.LNX.4.58.0408281011280.2295@ppc970.osdl.org> <20040828190350.GA14152@alias> <20040828190901.GA18083@lst.de>
In-Reply-To: <20040828190901.GA18083@lst.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it is reasonable to make the -nopseudos (turns off the metafiles 
) mount option mandatory, until the bugs are resolved.

Our testing did not find these metafile/VFS bugs because of the reason 
for all our bugs, we screwed up. 

There is a distinct difference between some persons and I, which is that 
some think all of reiser4 should be excluded until metafiles are 
implemented by VFS some long time from now, and I, in that I merely 
think buggy optional features should be turned off until they are 
fixed.  I, being renowned for my paranoia and asininity as I am, think 
these persons find it convenient as an excuse to keep us from competing, 
and I think that if we were slower there would be less hassle every time 
we try to get into the kernel. 

While reiser4 has some significant roughnesses remaining in its 
performance, I think the average user would find it performs better than 
other filesystems, and is stable enough for, say, a laptop, and I 
predict that by the time we have it stable enough for mission critical 
servers, all the roughness in various important corner cases will be 
gone.  

Persons benchmarking it with tarballs, please be sure to use tarballs 
created on reiser4, not ext2 tarballs, readdir order matters a lot for 
sorted directory filesystems.

Hans
