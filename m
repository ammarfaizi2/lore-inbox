Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292778AbSCIOX4>; Sat, 9 Mar 2002 09:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292779AbSCIOXr>; Sat, 9 Mar 2002 09:23:47 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:51597 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S292778AbSCIOXd>;
	Sat, 9 Mar 2002 09:23:33 -0500
Date: Sat, 9 Mar 2002 15:23:10 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203091423.PAA19796@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: MCE hang in 2.2.21pre4
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>Please save any 2.2 updates for 2.2.22pre from now on unless they are
>clear bug fixes. I hope to do a 2.2.21rc1 next
>
>2.2.21pre4
>o	Fix MCE address reporting order, fix oops with	(Dave Jones)
>	newer gcc due to bad asm constraints

Something in this part broke my Mobile Pentium II (Deschutes).
2.2.21pre3 boots fine, but 2.2.21pre4 hangs immediately after the
"Intel machine check architecture supported." line. gcc is 2.95.3.
2.4 and 2.5 kernels compiled with 2.95.3 also boot ok.

/Mikael
