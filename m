Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267399AbUHXKMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267399AbUHXKMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267404AbUHXKMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:12:32 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:21401 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267394AbUHXKMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:12:13 -0400
Date: Tue, 24 Aug 2004 11:11:42 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops modprobing i830 with 2.6.8.1
Message-ID: <Pine.LNX.4.58.0408241101390.26950@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just spotted this thread on reading the archives (I don't have the time
currently to subscribe to lk).. sorry for messing up the msg ids..

Rusty, I'm going to work something like your patch into the DRM at some
stage soon (I'm not confident it won't break things that don't need
AGP)... also the stub sharing stuff is needed to make /proc and all that
work at the moment, when we start moving the code to a core library and
modules (like AGP) the hope is most of this stuff will just go away..
the ground work for the library conversion is in CVS and I'll be pushing
it to Linus as soon as he decides on my current changesets,

Just for everyone else, we do have a plan for the DRM now for once, and
I'm taking all the suggestions on board as I go, the reason things make
take a while to make it into the kernel is I put into DRM CVS where it
gets tested on most of the cards we support first...

I'm also trying to get the development cycle from
me->CVS->BK->Andrew->Linus a bit shorter, but at the moment the DRM works
for most values of x, I don't want it to regress because we haven't tested
the patches enough...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

