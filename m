Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312986AbSC0Jrf>; Wed, 27 Mar 2002 04:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312985AbSC0JrP>; Wed, 27 Mar 2002 04:47:15 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:11493 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312984AbSC0JrK>; Wed, 27 Mar 2002 04:47:10 -0500
Date: Wed, 27 Mar 2002 11:35:58 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Matan <matan@svgalib.org>
Cc: Dave Jones <davej@suse.de>, Boris Bezlaj <boris@kista.gajba.net>,
        kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mdacon.c minor cleanups
In-Reply-To: <Pine.LNX.4.21_heb2.09.0203262345140.3857-100000@matan.home>
Message-ID: <Pine.LNX.4.44.0203271135340.25933-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Matan wrote:

> The mdacon.c in 2.4.18 does not actually test for an MDA card, it only
> test for ram where the MDA vram is. The problem is that almost any vga
> card maps ram to that address.
> There is a test, but it is somewhat wrong (it changes registers, but
> does not save and restore the original values) and is commented out. If
> you fix this and uncomment the test, it works in some cases (this was
> discussed under the subject "MDA video detection request" on July 2000).

Aah, thanks for clearing that up.

	Zwane

-- 
http://function.linuxpower.ca
		

