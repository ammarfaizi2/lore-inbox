Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313068AbSDEQiq>; Fri, 5 Apr 2002 11:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313063AbSDEQih>; Fri, 5 Apr 2002 11:38:37 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:32521 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S313062AbSDEQib>; Fri, 5 Apr 2002 11:38:31 -0500
Date: Fri, 5 Apr 2002 17:38:11 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] radeonfb 2.4.19-pre2
Message-ID: <20020405163811.GB1902@berserk.demon.co.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20020404214358.GA1811@berserk.demon.co.uk> <Pine.GSO.4.21.0204051214240.10408-100000@lisianthus.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@berserk.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 12:15:22PM +0200, Geert Uytterhoeven wrote:
> 
> If you use the palette in directcolor modes (instead of emulating truecolor
> mode), the console palette can be changed without redrawing the screen, just
> like in VGA text mode.
> 

Doesn't this then limit you to 32/64 colours in 15/16 bit mode (the
original code reject attempts to set palette entries above these indexes)
?

P.
