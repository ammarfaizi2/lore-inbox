Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317496AbSFDNVc>; Tue, 4 Jun 2002 09:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317497AbSFDNVb>; Tue, 4 Jun 2002 09:21:31 -0400
Received: from arsenal.visi.net ([206.246.194.60]:11926 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S317496AbSFDNVa>;
	Tue, 4 Jun 2002 09:21:30 -0400
X-Virus-Scanner: McAfee Virus Engine
Date: Tue, 4 Jun 2002 09:13:32 -0400
From: Ben Collins <bcollins@debian.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        andreas.bombe@munich.netsurf.de, linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] disable CONFIG_IEEE1394_PCILYNX_PORTS config option
Message-ID: <20020604131332.GI1250@blimpo.internal.net>
In-Reply-To: <Pine.NEB.4.44.0206041108400.8847-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 11:19:19AM +0200, Adrian Bunk wrote:
> Hi Marcelo,
> 
> IMHO it gives a bad picture of the quality of Linux if a stable kernel
> contains options that doesn't compile. CONFIG_IEEE1394_PCILYNX_PORTS
> doesn't compile (the error message is at the end of the mail) and Andreas
> Bombe stated in a private mail to me four months ago that it shouldn't
> have been a public option.
> 
> My patch doesn't do any harm because currently the kernel doesn't compile
> when this option is enabled and if someone fixes pcilynx.c it's pretty
> trivial to revert this patch.

We've already done this locally in our repo. Go ahead and apply this
patch if you want.



Ben

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://linux1394.sourceforge.net/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
