Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267296AbSLELeF>; Thu, 5 Dec 2002 06:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267297AbSLELeF>; Thu, 5 Dec 2002 06:34:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58124 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267296AbSLELeE>; Thu, 5 Dec 2002 06:34:04 -0500
Date: Thu, 5 Dec 2002 11:40:55 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net, jgarzik@pobox.com,
       miura@da-cha.org, alan@lxorguk.ukuu.org.uk, viro@math.psu.edu,
       pavel@ucw.cz
Subject: Re: [warnings] [2/8] fix uninitialized quot in drivers/serial/core.c
Message-ID: <20021205114055.B22686@flint.arm.linux.org.uk>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net, jgarzik@pobox.com,
	miura@da-cha.org, alan@lxorguk.ukuu.org.uk, viro@math.psu.edu,
	pavel@ucw.cz
References: <0212050252.hdcd1a.b3aUbzb5bCbGc3dkcCd8a1atc20143@holomorphy.com> <0212050252.AaCdAbid6d9cabJbEbmaTdZb7daa.c5a20143@holomorphy.com> <20021205111913.A18253@flint.arm.linux.org.uk> <20021205112539.GB18600@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021205112539.GB18600@holomorphy.com>; from wli@holomorphy.com on Thu, Dec 05, 2002 at 03:25:39AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 03:25:39AM -0800, William Lee Irwin III wrote:
> Before any of this happens, I'll try it out on more modern gcc's.

Some more info before you report the bug to the gcc people - looking at
my kernel build logs from the past week, it seems to be a gcc 2.95.x
thing (maybe a 2.96 thing as well).  It appears to be fixed in gcc 3.2.1.

I'm in favour of putting up with the incorrect warning produced by older
compilers.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

