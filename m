Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbTBPWFA>; Sun, 16 Feb 2003 17:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267610AbTBPWFA>; Sun, 16 Feb 2003 17:05:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8708 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265936AbTBPWE6>; Sun, 16 Feb 2003 17:04:58 -0500
Date: Sun, 16 Feb 2003 22:14:54 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Signal/gdb oddity in 2.5.61
Message-ID: <20030216221454.F12489@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <20030216191543.D12489@flint.arm.linux.org.uk> <20030216221023.GA6806@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030216221023.GA6806@nevyn.them.org>; from dan@debian.org on Sun, Feb 16, 2003 at 05:10:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 05:10:23PM -0500, Daniel Jacobowitz wrote:
> This is a consequence of ARM's separate get_signal_to_deliver. 
>
> Roland's changes for group stops require code in get_signal_to_deliver,
> so if you aren't using the common version, you're out of luck.
> 
> I think you'll have to either update yours to match, or use the new
> hooks David Miller added to use the common get_signal_to_deliver.

This is using the common version in 2.5.61.

You might want to completely review your reply in light of this.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

