Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131448AbRCWUmb>; Fri, 23 Mar 2001 15:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRCWUmM>; Fri, 23 Mar 2001 15:42:12 -0500
Received: from smtp.primusdsl.net ([209.225.164.93]:265 "EHLO
	mailhost.digitalselect.net") by vger.kernel.org with ESMTP
	id <S131448AbRCWUmI>; Fri, 23 Mar 2001 15:42:08 -0500
Date: Fri, 23 Mar 2001 15:43:28 -0500
From: James Lewis Nance <jlnance@intrex.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
Message-ID: <20010323154328.A14173@bessie.dyndns.org>
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com> <vba1yrr7w9v.fsf@mozart.stat.wisc.edu> <15032.1585.623431.370770@pizda.ninka.net> <vbay9ty50zi.fsf@mozart.stat.wisc.edu> <vbaelvp3bos.fsf@mozart.stat.wisc.edu> <20010322193549.D6690@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010322193549.D6690@unthought.net>; from jakob@unthought.net on Thu, Mar 22, 2001 at 07:35:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 07:35:49PM +0100, Jakob Østergaard wrote:

> My code here is quite template heavy, and I suspect that's what's triggering
> it.  In fact, I can't compile our development code with optimization, because
> GCC runs out of memory (it only allocates some 300-500 MB, but each page has
> it's own map in /proc/pid/maps, and a wc -l /proc/pid/maps doesn't finish for
> minutes).  My typical GCC eats 100-200 MB and runs for several minutes.

Would it be possible for you to post the preprocessor outout to this list?
It would be quite nice to have this testcase.

Jim
