Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbTA3Rbn>; Thu, 30 Jan 2003 12:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbTA3Rbn>; Thu, 30 Jan 2003 12:31:43 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:62159 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267560AbTA3Rbn>;
	Thu, 30 Jan 2003 12:31:43 -0500
Date: Thu, 30 Jan 2003 17:36:42 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Rodland <arodland@noln.com>,
       john@grabjohn.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.5.59 morse code panics
Message-ID: <20030130173642.GB25824@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Tomas Szepe <szepe@pinerecords.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Andrew Rodland <arodland@noln.com>, john@grabjohn.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030130150709.GC701@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030130150709.GC701@louise.pinerecords.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 04:07:09PM +0100, Tomas Szepe wrote:
 > Here's the initial port of Andrew Rodland's morse code panics to
 > 2.5.  It's probably got a few issues that need to be sorted out:
 > at least the acquisition of the atkbd handle is a shameful hack.
 > The original regular blinking code from ac has been removed,
 > because it's no use when we've got morse about. :)
 > 
 > Any comments appreciated, patch against 2.5.59.

I forwarded Linus a copy of Andi Kleens original
'blink leds on panic' patch circa 2.5.3 or so.
He rejected it due to not wanting PC-isms in kernel/

As this patch further builds upon the previous one,
It'd take a complete change of mind on his part to take
this as it is.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
