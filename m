Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266584AbSKGVBa>; Thu, 7 Nov 2002 16:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266577AbSKGVBa>; Thu, 7 Nov 2002 16:01:30 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2323 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266584AbSKGVB3>; Thu, 7 Nov 2002 16:01:29 -0500
Date: Thu, 7 Nov 2002 21:08:08 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Templates and tweaks (for size performance and more)
Message-ID: <20021107210808.D11437@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
References: <20021107190910.GC6164@opus.bloom.county> <20021107210304.C11437@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021107210304.C11437@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Nov 07, 2002 at 09:03:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, there's another problem built into this method as well.

Instead of one "tweak" depending on one configuration option, it suddenly
depends on a whole load of configuration options.  You change one of these
options, and you rebuild everything that uses the asm/tweaks.h (or whatever
the filename was.)

IMHO this is a backward step. ;(

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

