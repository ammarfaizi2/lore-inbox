Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbTAIEbf>; Wed, 8 Jan 2003 23:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbTAIEbf>; Wed, 8 Jan 2003 23:31:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14059 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261581AbTAIEbf>;
	Wed, 8 Jan 2003 23:31:35 -0500
Date: Wed, 08 Jan 2003 20:31:34 -0800 (PST)
Message-Id: <20030108.203134.64542534.davem@redhat.com>
To: dan@debian.org
Cc: torvalds@transmeta.com, levon@movementarian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030109040025.GA11596@nevyn.them.org>
References: <Pine.LNX.4.44.0301081601300.1096-100000@penguin.transmeta.com>
	<20030108.160352.78071329.davem@redhat.com>
	<20030109040025.GA11596@nevyn.them.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Jacobowitz <dan@debian.org>
   Date: Wed, 8 Jan 2003 23:00:25 -0500
   
   Just to clarify something that I saw getting lost in this discussion:
   Oprofile doesn't need to become built as a 64-bit binary, just
   configured to accept 64-bit kernels.  So this doesn't rule out using a
   32-bit oprofile (i.e. not needing a 64-bit libc) on a 64-bit kernel. 
   It just means that we need to specify it somehow.

That's right, indeed.  And furthermore, I'm willing to eat the 64-bit
overhead for all sparc builds. :)
