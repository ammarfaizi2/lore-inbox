Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbUDLPjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 11:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbUDLPjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 11:39:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19722 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262257AbUDLPjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 11:39:02 -0400
Date: Mon, 12 Apr 2004 16:38:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Ivica Ico Bukvic <ico@fuse.net>, "'Tim Blechmann'" <TimBlechmann@gmx.net>,
       "'Thomas Charbonnel'" <thomas@undata.org>, ccheney@debian.org,
       linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- FIXED!
Message-ID: <20040412163854.C12980@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Ritz <daniel.ritz@gmx.ch>,
	Ivica Ico Bukvic <ico@fuse.net>,
	'Tim Blechmann' <TimBlechmann@gmx.net>,
	'Thomas Charbonnel' <thomas@undata.org>, ccheney@debian.org,
	linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040412082801.A3972@flint.arm.linux.org.uk> <20040412144103.PIXB8029.smtp1.fuse.net@64BitBadass> <20040412155336.B12980@flint.arm.linux.org.uk> <200404121731.20765.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200404121731.20765.daniel.ritz@gmx.ch>; from daniel.ritz@gmx.ch on Mon, Apr 12, 2004 at 05:31:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 05:31:20PM +0200, Daniel Ritz wrote:
> EnE datasheet says it's also available in EnE 1211, 1225, 1420.
> and since they are TI clones why not for the TI's too?

Because the register supposedly does not exist on TI - it's likely to be
EnE specific.

I'm willing to bet that TI chips will behave as expected without touching
0xc9 at all.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
