Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTFNV13 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 17:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbTFNV13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 17:27:29 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:24963 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261153AbTFNV13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 17:27:29 -0400
Date: Sat, 14 Jun 2003 23:41:14 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Ryan Underwood <nemesis-lists@icequake.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mga dualhead console + gpm = instant reboot
Message-ID: <20030614214114.GE2776@vana.vc.cvut.cz>
References: <20030614014212.GC1010@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030614014212.GC1010@dbz.icequake.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 08:42:12PM -0500, Ryan Underwood wrote:
> Hello,
> 
> I run the mga dualhead console.  It works ok for the most part (some
> strange behavior on the second head happens that can be noticed in e.g.
> lynx when the cursor is blinking).  However, if I move the gpm mouse on
> the first head, switch to a console on the second head, move gpm mouse
> again, then switch back to a console on the first head, moving the mouse
> thereafter results in an instant reboot of the system.
> 
> Since there does not appear to be any kernel panic or oops, I am at a
> loss how to track the problem down.  Any ideas?

Kernel version? And if it is 2.4.x, did you boot with
'video=scrollback:0' ? If not, then please do so...
								Petr
 
