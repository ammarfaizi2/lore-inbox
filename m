Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266128AbSKFV0b>; Wed, 6 Nov 2002 16:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266141AbSKFV0a>; Wed, 6 Nov 2002 16:26:30 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:43534 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266128AbSKFV03>;
	Wed, 6 Nov 2002 16:26:29 -0500
Date: Wed, 6 Nov 2002 22:32:44 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Up silly limit on .config line length
Message-ID: <20021106213244.GC1035@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20021105233844.J24606@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211061425280.6949-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211061425280.6949-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 02:32:30PM +0100, Roman Zippel wrote:
> 
> I was already wondering, how much I should allow. :)
> But I'd rather set an arbitrary limit (and warn) than allowing an 
> arbitrary long string.
Since this has an unknown effect it should give an error, not just a
warning.
In the case raised by Russell an error would have been better, he would
never try to boot the kernel in that case.

	Sam
