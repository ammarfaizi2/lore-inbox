Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316889AbSFQRc5>; Mon, 17 Jun 2002 13:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSFQRc4>; Mon, 17 Jun 2002 13:32:56 -0400
Received: from arsenal.visi.net ([206.246.194.60]:48823 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S316889AbSFQRcz>;
	Mon, 17 Jun 2002 13:32:55 -0400
X-Virus-Scanner: McAfee Virus Engine
Date: Mon, 17 Jun 2002 13:23:14 -0400
From: Ben Collins <bcollins@debian.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
Message-ID: <20020617172314.GF7739@blimpo.internal.net>
References: <20020610181418.GA496@blimpo.internal.net> <Pine.LNX.3.95.1020610142403.17726B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020610142403.17726B-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 12:46:00PM -0400, Richard B. Johnson wrote:
> On Mon, 10 Jun 2002, Ben Collins wrote:
> 
> > On Mon, Jun 10, 2002 at 02:11:21PM -0400, Richard B. Johnson wrote:
> > > 
> > > 
> > > ---------- Forwarded message ----------
> > > From: "Richard B. Johnson" <root@chaos.analogic.com>
> > > Subject: Firewire Disks.
> > > 
> > > I know there is support for "firewire" in the kernel. Is there
> > > support for "firewire" disks? If so, how do I enable it?
> > > 
> > > Cheers,
> > > Dick Johnson
> > 
> > Compile and/or install the sbp2 module.
> > 
> 
> Okay. I did that. It doesn't work as for a 80 Gb hard disk, but
> it works for a CD-R/W.

You are using old drivers. The oddities with the newer SBP-2 drives has
been fixed in later 2.4.19-pre kernels, aswell as the source from our
subversion repository. You can get a tarball of the repo from here:

http://svn.debian.org/linux1394/tarballs/

Move drivers/ieee1394/ out of the way, and unpack that (still requires a
2.4.19-pre kernel though).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://linux1394.sourceforge.net/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
