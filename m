Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268076AbTBRWI2>; Tue, 18 Feb 2003 17:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268070AbTBRWHS>; Tue, 18 Feb 2003 17:07:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62733 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268056AbTBRWGP>; Tue, 18 Feb 2003 17:06:15 -0500
Date: Tue, 18 Feb 2003 22:16:11 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       davej@suse.de, linux@brodo.de
Subject: Re: Select voltage manually in cpufreq
Message-ID: <20030218221611.D9785@flint.arm.linux.org.uk>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>, davej@suse.de,
	linux@brodo.de
References: <20030218214220.GA1058@elf.ucw.cz> <20030218214726.GB15007@f00f.org> <20030218215819.GC21974@atrey.karlin.mff.cuni.cz> <20030218220858.GA15273@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030218220858.GA15273@f00f.org>; from cw@f00f.org on Tue, Feb 18, 2003 at 02:08:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 02:08:58PM -0800, Chris Wedgwood wrote:
> you pick two options, a slow and fast option; both should work

User control, yes.  System control can (and should) be fine grained.

Define "slow" when someone turns the framebuffer display off and you
don't need to satisfy its minimum requirement while you do still need
to keep something running in the background.

So now we have "slow", "not so slow" and "fast".

As I say, user control is by all means "I want fast" or "I want power
save" but you can't define "fast" and "slow" to mean anything without
examining the rest of the system state.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

