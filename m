Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWFIS76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWFIS76 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWFIS76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:59:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65174 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030396AbWFIS75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:59:57 -0400
Date: Fri, 9 Jun 2006 11:59:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: adilger@clusterfs.com, torvalds@osdl.org, alex@clusterfs.com,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-Id: <20060609115936.2fdda6d0.akpm@osdl.org>
In-Reply-To: <4489C0B8.7050400@garzik.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org>
	<448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	<20060609181020.GB5964@schatzie.adilger.int>
	<4489C0B8.7050400@garzik.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2006 14:40:56 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Andreas Dilger wrote:
> > Having a single codebase for everyone means that it is continually maintained
> > and users of ext3 aren't left out in the cold.
> 
> That implies continually upgrading ext3 for newer storage technologies, 
> which in turn implies adding all sorts of incompatible formats to 
> support better storage scaling, and new usage models.

Look, I'm not certain either way on this - I really don't like the format
incompatibility and I'd like to see a breakdown of the performance benefits
of each of the proposed new features so perhaps we can cherrypick.  And I'm
deferring judgement until I've looked at some patches.

But Jeff, please stop this wild exaggeration!  "continually upgrading",
"all sorts of incompatible formats".  It's not helping anything.  

Today's ext3 is, afaik, 100% on-disk compatible with ext3 from five years
ago, and probably with RH's 2.2-based implementation.  So we have not done
and will not do the things which you are FUDding us about.

This is (again, as far as I recall) the first on-disk-incompatible change
in ext3 which has ever been proposed.  It's not a thing which is done
lightly and it's not a thing which is likely to happen again for a very long
time indeed.

