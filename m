Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVAHPOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVAHPOL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 10:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVAHPOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 10:14:11 -0500
Received: from box.punkt.pl ([217.8.180.66]:23303 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261188AbVAHPOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 10:14:07 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] linux-libc-headers 2.6.10.0
Date: Sat, 8 Jan 2005 16:13:27 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501081613.27460.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
Changes:
- updated to 2.6.10
- switched to using svn and now ChangeLog is back :)
- some minor changes here and there (made some headers ansi C compatible)


Two weeks after 2.6.10, but you can blame Linus for releasing 2.6.10 just 
before Christmas.

Like I've said two months ago - my scripts for testing new versions now do 
separate asm-i386-ansi and asm-i386-noansi checks, so any ansi degradation in 
linux or asm-i386 (like the one from 2.6.9) won't go unnoticed.

One more thing - llh is now officially one year old (first commits are from 
December 2003). That's a long time for any hack to live. Especially a hack 
this big and one that even has a couple of vendor specific variants. A couple 
of discussions took place concerning this matter (in the last one Linus even 
said, that he'll be accepting patches) and still I see no movement. I'd 
really like to see glibc guys figuring out a way not to duplicate definitions 
and structures from linux and starting to submit patches. That'd be a really 
good (and much needed - glibc's and linux' headers conflict in lots of ugly 
ways) first step.
Anybody?

Happy New Year.

-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
