Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWG0MLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWG0MLs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 08:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWG0MLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 08:11:48 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:12955 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751158AbWG0MLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 08:11:48 -0400
Date: Thu, 27 Jul 2006 14:11:37 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: dean gaudet <dean@arctic.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 3ware disk latency?
Message-ID: <20060727121137.GM1703@fi.muni.cz>
References: <20060710141315.GA5753@fi.muni.cz> <Pine.LNX.4.64.0607260942110.22242@twinlark.arctic.org> <1153946249.13509.29.camel@localhost.localdomain> <Pine.LNX.4.64.0607261440470.4568@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607261440470.4568@twinlark.arctic.org>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
: my suspicion is the 3ware lacks any sort of "fairness" in its sharing of 
: buffer space between multiple units on the same controller.  and by 
: disabling the write caching it limits the amount of controller memory that 
: the busy disk can consume.

	Hmm, do you have a battery backup unit for 9550sx? I don't,
and the 3ware BIOS does not even allow me to enable write caching without it.
So I don't think the write caching on the controller side is related
to my problem.

	I have been able to improve the latency by upgrading the firmware
to the newest release (wow, they even have a firmware updating utility
for Linux!).

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> I will never go to meetings again because I think  face to face meetings <
> are the biggest waste of time you can ever have.        --Linus Torvalds <
