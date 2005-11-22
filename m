Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbVKVXDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbVKVXDB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVKVXDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:03:00 -0500
Received: from thunk.org ([69.25.196.29]:44168 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030229AbVKVXC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:02:58 -0500
Date: Tue, 22 Nov 2005 18:02:54 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Chris Adams <cmadams@hiwaay.net>, linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122230254.GC4035@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Chris Adams <cmadams@hiwaay.net>, linux-kernel@vger.kernel.org
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no> <20051122161712.GA942598@hiwaay.net> <Pine.LNX.4.64.0511221650360.2763@hermes-1.csi.cam.ac.uk> <20051122171847.GD31823@thunk.org> <Pine.LNX.4.64.0511221921530.7002@hermes-1.csi.cam.ac.uk> <20051122195201.GG31823@thunk.org> <Pine.LNX.4.64.0511221955130.7002@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511221955130.7002@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 08:00:58PM +0000, Anton Altaparmakov wrote:
> 
> What is your point?  I personally couldn't care less about POSIX (or any 
> other simillarly old-fashioned standards for that matter).  What counts is 
> reality and having a working system that does what I want/need it to do.  
> If that means violating POSIX, so be it.  I am not going to burry my head 
> in the sand just because POSIX says "you can't do that".  Utilities can be 
> taught to work with the system instead of blindly following standards.  

Finding all of the utilities and userspace applications that depend on
some specific POSIX behavior is hard; and convincing them to change,
instead of fixing the buggy OS, is even harder.  But that's OK, no one
has to use your filesystem (or operating system) if doesn't conform to
standards enough that your applications start breaking.

> And anyway the Linux kernel defies POSIX left, right, and centre so if you 
> care that much you ought to be off fixing all those violations...  (-;

Um, where?  Actually, we're pretty close, and we often spend quite a
bit of time fixing places where we don't conform to the standards
correctly.  Look at all of the work that's gone into the kernel to
make Linux's threads support POSIX compliant, for example.  We did
*not* tell everyone to go rewrite their applications to use
LinuxThreads, even if certain aspects of Posix threads are a little
brain-damaged.  

					- Ted
