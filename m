Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313044AbSC0R4V>; Wed, 27 Mar 2002 12:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313054AbSC0R4L>; Wed, 27 Mar 2002 12:56:11 -0500
Received: from [212.30.75.51] ([212.30.75.51]:52102 "EHLO
	radovan.kista.gajba.net") by vger.kernel.org with ESMTP
	id <S313044AbSC0Rz4>; Wed, 27 Mar 2002 12:55:56 -0500
Date: Wed, 27 Mar 2002 18:56:45 +0100
From: Boris <boris@kista.gajba.net>
To: Matan <matan@svgalib.org>
Cc: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: mdacon.c minor cleanups
Message-ID: <20020327185645.A9386@radovan.kista.gajba.net>
In-Reply-To: <Pine.LNX.4.44.0203250951520.14794-100000@netfinity.realnet.co.sz> <Pine.LNX.4.21_heb2.09.0203262345140.3857-100000@matan.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 11:17:39AM +0200, Matan wrote:
> 
> The mdacon.c in 2.4.18 does not actually test for an MDA card, it only
> test for ram where the MDA vram is. The problem is that almost any vga
> card maps ram to that address.
> There is a test, but it is somewhat wrong (it changes registers, but
> does not save and restore the original values) and is commented out. If
> you fix this and uncomment the test, it works in some cases (this was
> discussed under the subject "MDA video detection request" on July 2000).
> 
I am trying to add proper mda detection to the driver..
Current detection code is strange indeed.

Where are those messages archived somewhere ? I could find little info on mda cards so far..

	Boris
