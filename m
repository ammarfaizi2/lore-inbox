Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315884AbSEVPRA>; Wed, 22 May 2002 11:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315852AbSEVPQ7>; Wed, 22 May 2002 11:16:59 -0400
Received: from dc-mx09.cluster1.charter.net ([209.225.8.19]:57791 "EHLO
	mx09.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S315884AbSEVPQ6>; Wed, 22 May 2002 11:16:58 -0400
Date: Wed, 22 May 2002 11:16:44 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-rc4 linux/Documentation/sysctl/vm.txt out of date/sync with kernel
Message-ID: <20020522151644.GA18815@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: misty-@charter.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I have recently noticed on kernel 2.4.18-rc4 that the
documentation included in linux/Documentation/sysctl/vm.txt is obsolete
- things that exist (some of which I would find very useful!) in the
documentation do not exist in the current /proc/sys/vm/ directory.  Of
all of the features, the one I want the most to fiddle with is
'pagecache' which would let me mess around with the disk caching on my
ancient and some would say obsolete 486 with 16MB of ram. The reason is
because there are times when it's badly overloaded due to an obese
program (dpkg/apt-get usually. I use debian as my distribution) and I've
noticed it's got a little more than a third of ram devoted to disk
*cache* - which I would think would be better suited to trying to run
the program at that point! At the worst, fiddling with it would allow me
to learn if it improved or worsened the 486's speed at completing the
program and responsiveness during the experience.

Other things that do not exist in there that I would find useful to
tweak: buffermem, and freepages.

There are two procs in there which I didn't see any documentation in the
tree for: min-readahead max-readahead - I assume these are for file read
operations?

I enjoy using linux and hope my question doesn't bug anyone too much.

Tim McGrath
