Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281239AbRLBQaa>; Sun, 2 Dec 2001 11:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280814AbRLBQaS>; Sun, 2 Dec 2001 11:30:18 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:59911 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S281059AbRLBQaH>; Sun, 2 Dec 2001 11:30:07 -0500
Date: Sun, 2 Dec 2001 17:29:57 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: tim@cyberelk.net, Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: paride/Config.in and bool vs. mconfig 0.20
Message-ID: <20011202172957.A11453@emma1.emma.line.org>
Mail-Followup-To: tim@cyberelk.net,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to configure 2.4.17pre2 with mconfig 0.20, it said:

| drivers/block/paride/Config.in: 32: warning: bool command has extra
| arguments

And rightly so, bool wants the configuration question and the parameter,
nothing else.

Either that needs some dep_ stuff or it has indeed an extra argument, I
cannot decide which one is correct, so I'm not providing a patch now.

Would it be possible to fix this before 2.4.17 or 2.5.1 respectively?

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
