Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUEFJoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUEFJoB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 05:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUEFJoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 05:44:01 -0400
Received: from witte.sonytel.be ([80.88.33.193]:51349 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261932AbUEFJn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 05:43:59 -0400
Date: Thu, 6 May 2004 11:43:45 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>
cc: Zhenmin Li <zli4@cs.uiuc.edu>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [OPERA] Potential bugs detected by static analysis tool in 2.6.4
In-Reply-To: <002701c4331c$092a3b40$76f6ae80@Turandot>
Message-ID: <Pine.GSO.4.58.0405061141290.12096@waterleaf.sonytel.be>
References: <002701c4331c$092a3b40$76f6ae80@Turandot>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2004, Zhenmin Li wrote:
> We ran our static analysis tool upon Linux 2.6.4 source files, and found
> some potential errors. Since all of them are detected by the tool, we need
> more effort to inspect. We would appreciate your help if anyone can verify
> whether they are bugs or not.
>
> Thanks a lot,
>
> OPERA Research Group
> University of Illinois at Urbana-Champaign
>
>
>
> Version: 2.6.4

    [...]

> 8. /arch/m68k/mac/iop.c, Line 164:

Should be line 264?

> iop_base[IOP_NUM_SCC]->status_ctrl = 0;
>
> Maybe change to:
> iop_base[IOP_NUM_ISM]->status_ctrl = 0;

Mac guys, is this correct?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
