Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbUKFVmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbUKFVmG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 16:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUKFVmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 16:42:05 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:51215 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261481AbUKFVl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 16:41:57 -0500
Date: Sat, 6 Nov 2004 22:41:47 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: bloat
Message-ID: <20041106214147.GA9663@pclin040.win.tue.nl>
References: <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl> <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041106120716.GA9144@pclin040.win.tue.nl> <Pine.LNX.4.58.0411060922260.2223@ppc970.osdl.org> <20041106193605.GL1295@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106193605.GL1295@stusta.de>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: CollegeOfNewCaledonia: mailhost.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 08:36:08PM +0100, Adrian Bunk wrote:

> It's even harder because some subsystem maintainers refuse to remove 
> unused global functions that might be used at some point far in the 
> future or that even are never intended for in-kernel usage...

I have one or two unused functions inside #if 0 in sddr09.c.
Finding out the proper hardware details was nontrivial,
it would be a pity to throw the knowledge away.
But of course there is never a reason to have an unused function
appear in the binary. It is only source bloat.

Andries
