Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbUBGVUR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 16:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265838AbUBGVUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 16:20:17 -0500
Received: from smtp-out7.blueyonder.co.uk ([195.188.213.10]:51606 "EHLO
	smtp-out7.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265835AbUBGVUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 16:20:14 -0500
Message-ID: <4025568D.5070800@blueyonder.co.uk>
Date: Sat, 07 Feb 2004 21:20:13 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: Cisco vpnclient prevents proper shutdown starting with 2.6.2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2004 21:20:13.0041 (UTC) FILETIME=[2C5EA610:01C3EDC0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meinhard E. Mayer wrote:
 > Until version 2.6.1 the Cisco VPN module (version 4.0.3(B)) cisco_ipsec,
 > although "tainted" worked fine with all 2.4.22 and 2.6 kernel versions.
 > However, for 2.6.2, although the module compiles and loads, starting the
 > vpnclient hangs, and the client cannot be stoped (i.e.
 > /etc/init.d/vpnclient_init stop also hangs, and therefore both shutdown
 > and reboot of the computer do not complete, and I was forced to "pull
 > the plug." Fortunately the journaled file system prevented serious
 > damage.
 >
 > I used the same .config (which I append) for compiling 2.6, 2.6.1, and
 > 2.6.2, so I assume that something in your networking drivers must have
 > changed to cause this bug.
 >
 > I would appreciate any suggestions for fixing this problem, since I need
 > VPN to access the University library.
I tried using this client with up to 2.6.1-mm5 and ended up with  Dead 
processes for cvpnd and vpnclient, nothing else was affected, went back 
to 2.4.x kernel.
Regards
Sid

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

