Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbSKKKLg>; Mon, 11 Nov 2002 05:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265999AbSKKKLg>; Mon, 11 Nov 2002 05:11:36 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:46852 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S265998AbSKKKLg>; Mon, 11 Nov 2002 05:11:36 -0500
Date: Mon, 11 Nov 2002 11:17:57 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Heusden van, FJJ (Folkert)" <F.J.J.Heusden@rn.rabobank.nl>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: random PID patch
Message-ID: <20021111101757.GB285@louise.pinerecords.com>
References: <11D18E6D1073547-1319@_rabobank.nl_>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11D18E6D1073547-1319@_rabobank.nl_>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've ported my random-PID-patch from 2.2.19 to 2.4.19.
> > It should be downloadable from
> > http://www.vanheusden.com/Linux/fp-2.4.19.patch.gz
> > (or follow the link from
> > http://www.vanheusden.com/Linux/kernel_patches.php3 )
> RSK> hm
> RSK> what's the point of random PIDs?
> 
> Sometimes, (well; frequently) programs that create temporary
> files let the filename depend on their PID. A hacker could use
> that knowledge. So if you know that the application that
> you're starting uses the last PID+1, you could make sure that
> that file already exists or create a symlink with that name or
> whatsoever causing the application you're starting to do
> things it's not supposed to. Like forcing suid apps to create
> a file in the startup-scripts dir. or something.

How about I create 2^15 symlinks then?
Really, the only true solution to this problem is to fix the apps.

-- 
Tomas Szepe <szepe@pinerecords.com>
