Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130324AbRAHSvK>; Mon, 8 Jan 2001 13:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130378AbRAHSvC>; Mon, 8 Jan 2001 13:51:02 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:63500 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S130164AbRAHSus>; Mon, 8 Jan 2001 13:50:48 -0500
Date: Mon, 8 Jan 2001 19:44:34 +0100
From: Michal Medvecky <M.Medvecky@sh.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: blinking vga card
Message-ID: <20010108194434.D7673@devitka.sh.cvut.cz>
Mail-Followup-To: linux-kernel@vger.rutgers.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
X-Mailer: Mutt 1.0pre3us
X-Mailer: Mutt http://www.mutt.org/
X-Location: 9/333
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have following problem:
when I make big load on my PC, my monitor starts blinking in XFree 4.0.2 (precompiled binaries from xfree86.org), and does not stop until reboot.
It has been blinking on 4.0.0, so I upgraded to 4.0.1 and then to 4.0.2, and problem persists.
I have first tried to replace VGA card with another one. It did not help.
Then, I've tried to recompile kernel without support of APM and other problematic things - but it still persists.
I've tried to underclock RAM and CPU. No solution. It still blinks.
Because I have this problem also with XFree 3.3.x, I think that problem is in kernel. The problem does not seem to exist in Microsoft Windows 9x, so I think it is not hardware problem.

Do you have any idea where the problem may be?

I have AMD Athlon 650MHZ, 128mb ram (133mhz), Epox KX-7 with via chipset, RIVA TNT M64 with 32MB RAM. I'm using slackware-7.1 with kernel 2.2.18, patched with agpgart, stealth patch and openwall. 

Thank you very much

Michal Medvecky

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
