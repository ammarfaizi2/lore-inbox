Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbTEAX7S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 19:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTEAX7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 19:59:18 -0400
Received: from pat.uio.no ([129.240.130.16]:39041 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262816AbTEAX7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 19:59:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16049.47030.861152.708686@charged.uio.no>
Date: Fri, 2 May 2003 02:11:34 +0200
To: Bojan Smojver <bojan@rexursive.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.68: NFS3+exported /mnt/cdrom+eject: system lockup
In-Reply-To: <1051829732.1529.2.camel@coyote.rexursive.com>
References: <1051754203.3eb07edb09c51@imp.rexursive.com>
	<shsd6j3gdan.fsf@charged.uio.no>
	<1051829732.1529.2.camel@coyote.rexursive.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Bojan Smojver <bojan@rexursive.com> writes:

     > Anyway, I have observed other strange stuff too, like not being
     > able to unmount /mnt/cdrom while it's being
     > exported.

That is *correct* behaviour. If the partition is exported, then it is
in use.

     > Workaround: stop NFS, unmount, start NFS. Not sure if this is
     > normal or not...

Either that, or you unexport it, then umount.

Cheers,
  Trond
