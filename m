Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVDHGk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVDHGk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 02:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVDHGk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 02:40:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:45748 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262707AbVDHGjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 02:39:36 -0400
Date: Thu, 7 Apr 2005 23:41:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Pool <mbp@sourcefrog.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
Subject: Re: Kernel SCM saga..
In-Reply-To: <1112939769.29544.161.camel@hope>
Message-ID: <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> 
 <20050406193911.GA11659@stingr.stingr.net>  <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
  <20050407014727.GA17970@havoc.gtf.org>  <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
  <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz>  <1112852302.29544.75.camel@hope>
  <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2005, Martin Pool wrote:
> 
> You can get the current bzr development tree, stored in itself, by
> rsync:

I was thinking more of an exportable kernel tree in addition to the tool.

The reason I mention that is just that I know several SCM's bog down under 
load horribly, so it actually matters what the size of the tree is.

And I'm absolutely _not_ asking you for the 60,000 changesets that are in
the BK tree, I'd be prfectly happy with a 2.6.12-rc2-based one for
testing.

I know I can import things myself, but the reason I ask is because I've
got several SCM's I should check out _and_ I've been spending the last two
days writing my own fallback system so that I don't get screwed if nothing
out there works right now. 

Which is why I'd love to hear from people who have actually used various 
SCM's with the kernel. There's bound to be people who have already tried.

I've gotten a lot of email of the kind "I love XYZ, you should try it 
out", but so far I've not seen anybody say "I've tracked the kernel with 
XYZ, and it does ..."

So, this is definitely not a "Martin Pool should do this" kind of issue: 
I'd like many people to test out many alternatives, to get a feel for 
where they are especially for a project the size of the kernel..

		Linus
