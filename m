Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbUFJWfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUFJWfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 18:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUFJWfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 18:35:48 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:32648 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263169AbUFJWfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 18:35:40 -0400
Date: Fri, 11 Jun 2004 00:35:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Dave Jones <davej@redhat.com>, Chris Mason <mason@suse.com>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
Message-ID: <20040610223532.GB3340@wohnheim.fh-wedel.de>
References: <20040609122226.GE21168@wohnheim.fh-wedel.de> <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <1086801345.10973.263.camel@watt.suse.com> <40C75141.7070408@namesys.com> <20040609182037.GA12771@redhat.com> <40C79FE2.4040802@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40C79FE2.4040802@namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 16:40:18 -0700, Hans Reiser wrote:
> >
> Forcing kernel developers to distort their coding to keep stack sizes 
> small is not a good idea, as it makes the whole kernel harder to code 
> for a not very compelling (for 99% of users, please argue with me if you 
> think it is otherwise) benefit.
> 
> I do not think I favor disturbing V3's stability for the sake of the 4k 
> stack option, but my mind is still open.

Apart from the fact that v3 appears to be safe on this front, your
perspective of kernel development doesn't seem to match that of most
developers.

o The kernel proper has no stable interface, it changes all of the
time.  Breaking peripheral kernel code (i.e. filesystems and device
drivers) with any change is not considered a problem.  If someone
cares about the peripheral code, it will get fixed.

o Noone has special rights to any code in the kernel.  You've accepted
the GPL and thereby given anyone the right to make changes to reiser3
and to distribute the changed code.  Active maintainership is usually
valued, but without that, noone is special.

It appears to me that most developers agree to the two point above,
but you have some problems with them, at least lately.  Am i wrong?

Jörn

-- 
When you close your hand, you own nothing. When you open it up, you
own the whole world.
-- Li Mu Bai in Tiger & Dragon
