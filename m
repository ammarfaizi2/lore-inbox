Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312503AbSCUVZq>; Thu, 21 Mar 2002 16:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312504AbSCUVZh>; Thu, 21 Mar 2002 16:25:37 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:58000
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S312503AbSCUVZ2>; Thu, 21 Mar 2002 16:25:28 -0500
Date: Thu, 21 Mar 2002 14:21:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
Message-ID: <20020321212110.GJ25237@opus.bloom.county>
In-Reply-To: <3C985A46.D3C73301@aitel.hist.no> <Pine.LNX.4.44.0203200943230.3615-100000@xanadu.home> <a7dev9$n51$1@cesium.transmeta.com> <20020321210356.GI25237@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 02:03:56PM -0700, Tom Rini wrote:
> On Thu, Mar 21, 2002 at 12:14:33PM -0800, H. Peter Anvin wrote:
> > Followup to:  <Pine.LNX.4.44.0203200943230.3615-100000@xanadu.home>
> > By author:    Nicolas Pitre <nico@cam.org>
> > In newsgroup: linux.dev.kernel
> > >
> > > On Wed, 20 Mar 2002, Helge Hafting wrote:
> > > 
> > > > Nicolas Pitre wrote:
> > > > 
> > > > > > Removable media?
> > > > > 
> > > > > Most if not all removable media are not ment to be used with JFFS2.
> > > > 
> > > > Nothing is _meant_ to be exploited either.  Someone could
> > > > create a cdrom with jffs2 (linux don't demand that cd's use iso9660)
> > > 
> > > But JFFS2 demands to be used with AN MTD device, not a block device.  And
> > > most MTD device, if not all of them, on which JFFS2 is used aren't
> > > removable.
> > 
> > Isn't this whole discussion a bit silly?  If I'm not mistaken, we're
> > talking about a one-line known fix here...
> 
> It's getting there.

Correction, it is there since it's been fixed in 2.4.19-pre4 anyhow.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
