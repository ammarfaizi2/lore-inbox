Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbTAFPX7>; Mon, 6 Jan 2003 10:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbTAFPX7>; Mon, 6 Jan 2003 10:23:59 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:18143 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266578AbTAFPX7>;
	Mon, 6 Jan 2003 10:23:59 -0500
Date: Mon, 6 Jan 2003 15:30:48 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Stephen Thomas <mail@stephenthomas.uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: E7205/E7505 support in 2.4
Message-ID: <20030106153047.GA5178@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Stephen Thomas <mail@stephenthomas.uklinux.net>,
	linux-kernel@vger.kernel.org
References: <3E199EBA.7040807@stephenthomas.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E199EBA.7040807@stephenthomas.uklinux.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 03:20:26PM +0000, Stephen Thomas wrote:

 > I notice that 2.5 kernels now have explicit support for this
 > chipset, while 2.4 don't seem to.  So, if I ran a 2.4 kernel
 > on such a machine, would it a) not work, b) work fine, or
 > c) work OK but not as well as it could do?

The only part I'm aware of in 2.5 is the AGPGART support which
recently got added. 2.4 lacks AGP3.0 support which this relies
upon, so in 2.4 you'll get unaccelerated 3d (DRI won't work)
unless you add the 2.4 patch that was posted a while back.

Jeff Hartmann has been working on agpgart silently all this time,
and aparently has AGP3.0 patches for 2.4 pending, so it could
turn around quite soon.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
