Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281252AbRLDReZ>; Tue, 4 Dec 2001 12:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283274AbRLDRdE>; Tue, 4 Dec 2001 12:33:04 -0500
Received: from ns.caldera.de ([212.34.180.1]:7111 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S281561AbRLDRbl>;
	Tue, 4 Dec 2001 12:31:41 -0500
Date: Tue, 4 Dec 2001 18:30:45 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Michael Elizabeth Chastain <mec@shout.net>
Cc: esr@thyrsus.com, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204183045.A13725@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Michael Elizabeth Chastain <mec@shout.net>, esr@thyrsus.com,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <200112041718.LAA21719@duracef.shout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112041718.LAA21719@duracef.shout.net>; from mec@shout.net on Tue, Dec 04, 2001 at 11:18:38AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 11:18:38AM -0600, Michael Elizabeth Chastain wrote:
> As far as CML2 versus an mconfig-based solution, I am tilted towards CML2,
> as it is simply a better language.  I would be happy with either choice
> if Linus made one of those choices.  I would be unhappy if 2.6/3.0
> continued to ship with Configure/menuconfig/xconfig.

Indepenand of wether 2.6 will use CML1 or CML2 I hope it won't ship with
the actual config tool.  It's so much nicer to have mconfig compiled once
in /usr/bin instead of compiling menuconfig all the time in the tree.

No to mention it's much easier to propagate bug fixes this way..

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
