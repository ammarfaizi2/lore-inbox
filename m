Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbUDZRcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUDZRcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 13:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbUDZRcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 13:32:25 -0400
Received: from ns.suse.de ([195.135.220.2]:44008 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263226AbUDZRcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 13:32:23 -0400
Subject: Re: I oppose Chris and Jeff's patch to add an unnecessary
	additional namespace to ReiserFS
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, akpm@osdl.org
In-Reply-To: <408D3FEE.1030603@namesys.com>
References: <1082750045.12989.199.camel@watt.suse.com>
	 <408D3FEE.1030603@namesys.com>
Content-Type: text/plain
Message-Id: <1083000711.30344.44.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Apr 2004 13:31:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-26 at 12:59, Hans Reiser wrote:

> In the free software community you have to produce working code to be 
> paid attention to.  We are doing that.  Chris is sending his patch in at 
> this time in part because V4 is about to make his work completely 
> obsolete.  

We write patches for v3 because that is what our users are using.  We
write patches to support xattrs because those are the interfaces that
linux as a whole supports.  

v4 didn't factor into these decisions because it was still in extremely
early stages back then (2.4.16 or so).

I welcome v4, it has a lot of improvements over v3 and I very much want
to see v4 (and namesys) succeed.

> I also view 
> V3 as stable code that should not be disturbed more than minimally 
> necessary, and I desire for all new functionality to go into V4 (Chris 
> was also told that before his patch was written).
> 

You can't release v4 and then expect all the v3 users to disappear
instantly.  Our users have an expectation that the filesystem they
choose for their production systems will be reasonably maintained over
time.

I consider supporting the linux standard interfaces for acls and xattrs
part of being reasonably maintained, and the pending release of v4
doesn't change that.

> Making it possible to unify operating system namespaces was why ReiserFS 
> was created.  I am not in this for the money.  Pasting in an additional 
> namespace beyond what Unix had for short term marketing reasons violates 
> its soul, and I have no desire to provide support for it as it 
> complicates one feature at a time over 30 years.
> 
Disliking the xattr interface is a different discussion.  We
specifically did not do new and interesting namespace research with the
v3 patches, we supported the existing apis in as plain and non-intrusive
a manner possible.

These patches were not a quick hack, a lot of thought went into making
them usable in existing v3 installations, and they have been around for
quite a while.

-chris


