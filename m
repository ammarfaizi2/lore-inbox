Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbUJYI0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbUJYI0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUJYIZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:25:22 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:4225 "EHLO
	midnight.suse.cz") by vger.kernel.org with ESMTP id S261410AbUJYIXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 04:23:36 -0400
Date: Mon, 25 Oct 2004 10:23:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stephen Wille Padnos <spadnos@sover.net>
Cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org,
       geert@linux-m68k.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041025082314.GA1433@ucw.cz>
References: <Pine.LNX.4.58.0410232104510.3984@be1.lrz> <417C5A91.40008@sover.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417C5A91.40008@sover.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 09:44:49PM -0400, Stephen Wille Padnos wrote:

> >Since some VGA cards used to depend on the MDA/CGA BIOS routines, most
> >(all?) BIOS variants will implement all nescensary IO functions. You'll
> >need some MDA registers for the cursor position (that don't even clash with
> >EGA/VGA/CGA), 4K mapped memory at B000:0000 and a loop translating the 
> >text.

> Right - all video cards provide these BIOS routines (including one the 
> one being considered here).  They aren't in the system BIOS.  (Not that 
> there are no broken BIOSes around, but strictly speaking, there is no 
> need at all for the system BIOS to know anything about the display card 
> being used)
 
Wrong - the CGA/MDA cards didn't come with any BIOS on them, and all the
support routines were (and most probably still are) located in the
system BIOS. The first card that replaced IRQ 10 with it's own set of
routines was the EGA and used its own BIOS ROM for that.

So there is no need to have a BIOS on the card to still see the system
BIOS boot messages.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
