Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268238AbTBYTLg>; Tue, 25 Feb 2003 14:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268247AbTBYTLg>; Tue, 25 Feb 2003 14:11:36 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:26087 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP
	id <S268238AbTBYTLe>; Tue, 25 Feb 2003 14:11:34 -0500
Date: Tue, 25 Feb 2003 14:21:11 -0500
From: daveman@bellatlantic.net
To: Jerry Cooperstein <coop@axian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Thinkpad Keyboard nuttiness since 2.5.60 with power management
Message-ID: <20030225192110.GA2036@bellatlantic.net>
Reply-To: daveman@bellatlantic.net
References: <20030224230640.GA1225@p3.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224230640.GA1225@p3.attbi.com>
User-Agent: Mutt/1.4i
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [157.182.138.149] at Tue, 25 Feb 2003 13:21:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 03:06:40PM -0800, Jerry Cooperstein wrote:
> Since 2.5.60 the keyboard on my Thinkpad 600X randomly
> autorepeats each stroke multiple times, only when
> power management is enabled (either APM or ACPI) and
> only when powered up with no AC power.  With AC power
> everything is fine, and pulling the plug out has
> no effects.
> 
> Everything was fine in 2.5.59, and I can't find anything
> in the 2.5.59->2.5.60 patch that could have caused this.
> Anyone else see this -- or maybe I have a hardware problem
> the patch is making visible?
> 
> Thanks
> 
> ======================================================================
>  Jerry Cooperstein,  Senior Consultant,  <coop@axian.com>
>  Axian, Inc., Software Consulting and Training
>  4800 SW Griffith Dr., Ste. 202,  Beaverton, OR  97005 USA
>  http://www.axian.com/               
> ======================================================================

I am seeing a strange keyboard related issue as well on a Thinkpad A20M. It seems if I walk away for say, 20 minutes, come back and try to input a password to KDE's screen saver, the FIRST keystroke I make is not recognized at all. All keystrokes after the first one register perfectly fine. This is on the laptop's built-in keyboard. I too am using ACPI. If I don't wait long enough it doesn't happen, so I do believe it has something to do with power management. I first noticed it in 2.5.61(first 2.5 kernel that would boot for me) and am currently running 2.5.63, where I still see it. I am not using modules.

If anyone would like more info on this, please let me know.

--David Shepard
