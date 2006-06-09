Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965257AbWFIUzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbWFIUzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWFIUzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:55:17 -0400
Received: from [80.71.248.82] ([80.71.248.82]:9357 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S965257AbWFIUzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:55:15 -0400
X-Comment-To: Linus Torvalds
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org>
	<1149885135.5776.100.camel@sisko.sctweedie.blueyonder.co.uk>
	<Pine.LNX.4.64.0606091344290.5498@g5.osdl.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Sat, 10 Jun 2006 00:56:26 +0400
In-Reply-To: <Pine.LNX.4.64.0606091344290.5498@g5.osdl.org> (Linus Torvalds's message of "Fri, 9 Jun 2006 13:46:28 -0700 (PDT)")
Message-ID: <m3bqt259qd.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Linus Torvalds (LT) writes:

 LT> On Fri, 9 Jun 2006, Stephen C. Tweedie wrote:
 LT> Btw, where did that 2TB limit number come from? Afaik, it should be 16TB 
 LT> for a 4kB filesystem, no?

2TB => 16K group descriptors * 8 (sizeof(void*) on 64bit arch) => 128K -- slab limit

we have a fix for this as well.

thanks, Alex
