Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbTL3VsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 16:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbTL3VsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 16:48:22 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:16650 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265732AbTL3VsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 16:48:20 -0500
Date: Tue, 30 Dec 2003 17:37:42 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0+BK keyboard problems
Message-ID: <20031230163742.GB17107@win.tue.nl>
References: <Pine.GSO.4.44.0312301157210.23594-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0312301157210.23594-100000@math.ut.ee>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 12:04:31PM +0200, Meelis Roos wrote:

> Additionally, when X starts, these two messages appear in dmesg:
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).

That is a kernel debugging message bug.
You got an ACK from the keyboard, 0xfa, and that is not unknown, and
not the release of a key with scancode 0x7a.
