Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265149AbUFRNDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUFRNDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 09:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUFRNDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 09:03:22 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:9171 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265149AbUFRNDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 09:03:18 -0400
Date: Fri, 18 Jun 2004 15:02:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <ft01@webmastery.com.au>, Andreas Schwab <schwab@suse.de>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: make checkstack on m68k
Message-ID: <20040618130242.GD18258@wohnheim.fh-wedel.de>
References: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be> <je3c4uqum0.fsf@sykes.suse.de> <Pine.LNX.4.58.0406180048180.13963@bonkers.disegno.com.au> <20040617182658.GB29029@wohnheim.fh-wedel.de> <Pine.GSO.4.58.0406172115050.1495@waterleaf.sonytel.be> <Pine.GSO.4.58.0406172130130.1495@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.GSO.4.58.0406172130130.1495@waterleaf.sonytel.be>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 June 2004 21:36:11 +0200, Geert Uytterhoeven wrote:
> 
> *bummer*
> 
> why doesn't checkstack.pl complain if I forget to specify `m68k'?!?

It tries to guess the architecture on it's own.  Guessing is not
working for m68k, aparently.

What does "uname -m" tell you?

[ Yes, this breaks for cross compilation.  If anyone really cares,
please send patches. ]

Jörn

-- 
The strong give up and move away, while the weak give up and stay.
-- unknown
