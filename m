Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbUJWUAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbUJWUAL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUJWUAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:00:08 -0400
Received: from box.punkt.pl ([217.8.180.66]:33032 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261297AbUJWT6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 15:58:14 -0400
From: Mariusz Mazur <mmazur@kernel.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] linux-libc-headers 2.6.9.0
Date: Sat, 23 Oct 2004 21:56:45 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410232156.45908.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
Changes:
- updated to 2.6.9
- added m32r arch (haven't cleaned it too much though)
- in asm/page.h use getpagesize() on all archs
- some fixes here and there


Do note I'm having some technical problems with the script that generates the 
ChangeLog file so (a) it's empty in this release and (b) I might have missed 
something in the above list.
As to getpagesize() - as was suggested I've switched all PAGE_SIZE definitions 
to use that function on all archs so there's going to be lots of fun with 
fixing apps.

Enjoy.

-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
