Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWFJWNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWFJWNM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 18:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWFJWNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 18:13:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:64966 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161032AbWFJWNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 18:13:10 -0400
Message-ID: <448B43EB.6050607@garzik.org>
Date: Sat, 10 Jun 2006 18:12:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: Linus Torvalds <torvalds@osdl.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       Chase Venters <chase.venters@clientec.com>,
       Alex Tomas <alex@clusterfs.com>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org> <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org> <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <4489C580.7080001@garzik.org> <17D07BC0-4B41-4981-80F5-7AAEC0BB6CC8@mac.com> <Pine.LNX.4.64.0606101238110.5498@g5.osdl.org> <Pine.LNX.4.64.0606101248030.5498@g5.osdl.org> <20060610212624.GD6641@thunk.org>
In-Reply-To: <20060610212624.GD6641@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> 	As far as people who want to use ext3 as the beginning point
> to do something that is has no forwards- compatibility, there's
> nothing stopping them from creating a jgarzikfs if they want.  But I
> think I can speak for most of the ext3 development community that we
> feel that one of the strengths of ext2/3 is its ability to do smooth
> upgrades (and in many cases, downgrades as well, when people need to
> migrate a filesystem so it can be mounted on older kernels), and that
> it's one of the reasons why ext3 has been more succesful, than say,
> JFS. 

When did I ever say smooth upgrades were a bad idea?

The whole point of 'cp -a ext3 ext4' is to ensure smooth upgrades 
continue.  A key theme is to avoid -backporting- all this new stuff 
that's going into ext4.  IMO ext3 shouldn't be a devel platform at this 
point in its lifecycle.

	Jeff



