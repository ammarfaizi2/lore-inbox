Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264240AbTDOEdZ (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 00:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTDOEdZ (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 00:33:25 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:53378 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264240AbTDOEdY (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 00:33:24 -0400
Date: Tue, 15 Apr 2003 05:45:05 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
Message-ID: <20030415044505.GA25139@mail.jlokier.co.uk>
References: <16025.63003.968553.194791@nanango.paulus.ozlabs.org> <Pine.GSO.4.21.0304141037410.28305-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0304141037410.28305-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> > Since __ide_mm_insw doesn't get told whether it is transferring normal
> > sector data or drive ID data, it can't necessarily do the right thing
> > in both situations.
> 
> Indeed. Ataris and Q40/Q60s have byteswapped IDE busses, but they expect
> on-disk data to be that way, for compatibility with e.g. TOS.

Isn't that best solved in the TOS filesystem code?

That way, Ataris running Linux can read ext2 disks from other systems
properly, and other systems can read TOS disks written by Ataris
properly.

Or did I miss something?

-- Jamie

