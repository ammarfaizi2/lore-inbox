Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283708AbRLEDV7>; Tue, 4 Dec 2001 22:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283712AbRLEDVu>; Tue, 4 Dec 2001 22:21:50 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:55282
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S283708AbRLEDVg>; Tue, 4 Dec 2001 22:21:36 -0500
Date: Tue, 4 Dec 2001 19:21:28 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Christoph Hellwig <hch@caldera.de>,
        Michael Elizabeth Chastain <mec@shout.net>, esr@thyrsus.com,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204192128.B25292@mikef-linux.matchmail.com>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Michael Elizabeth Chastain <mec@shout.net>, esr@thyrsus.com,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <200112041718.LAA21719@duracef.shout.net> <20011204183045.A13725@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011204183045.A13725@caldera.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 06:30:45PM +0100, Christoph Hellwig wrote:
> On Tue, Dec 04, 2001 at 11:18:38AM -0600, Michael Elizabeth Chastain wrote:
> > As far as CML2 versus an mconfig-based solution, I am tilted towards CML2,
> > as it is simply a better language.  I would be happy with either choice
> > if Linus made one of those choices.  I would be unhappy if 2.6/3.0
> > continued to ship with Configure/menuconfig/xconfig.
> 
> Indepenand of wether 2.6 will use CML1 or CML2 I hope it won't ship with
> the actual config tool.  It's so much nicer to have mconfig compiled once
> in /usr/bin instead of compiling menuconfig all the time in the tree.
> 
> No to mention it's much easier to propagate bug fixes this way..
> 

If the configure system is outside of the kernel, you have the possibility
of requiring newer user-space utilities as a stable kernel changes over
time...
