Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262642AbTCIWHv>; Sun, 9 Mar 2003 17:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262644AbTCIWHv>; Sun, 9 Mar 2003 17:07:51 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:18437 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262642AbTCIWHu>; Sun, 9 Mar 2003 17:07:50 -0500
Date: Sun, 9 Mar 2003 23:18:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries Brouwer <aebr@win.tue.nl>
cc: Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: struct inode size reduction.
In-Reply-To: <20030309203144.GA3814@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0303092310470.32518-100000@serv>
References: <20030309135402.GB32107@suse.de> <20030309171314.GA3783@win.tue.nl>
 <20030309203359.GA7276@suse.de> <20030309195555.A22226@infradead.org>
 <20030309203144.GA3814@win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Mar 2003, Andries Brouwer wrote:

> [I already submitted the patch throwing it out, but someone,
> maybe it was Roman Zippel, complained that that was going
> in the wrong direction. In the very long run that may be true
> (or not), but for 2.6 I do not see the point of this dead code.]

My main question here is whether that code hurts in any way? Does it 
prevent other cleanups? Sure this code needs more work to be really 
useful, but as long as it only wastes a bit of space, I'd prefer to keep 
it.

bye, Roman

