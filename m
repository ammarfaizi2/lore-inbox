Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbVCVLuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVCVLuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbVCVLuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:50:07 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59832 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262646AbVCVLuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:50:02 -0500
Date: Tue, 22 Mar 2005 12:49:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Hikaru1@verizon.net
cc: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
In-Reply-To: <20050322112628.GA18256@roll>
Message-ID: <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com> <20050322112628.GA18256@roll>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>This will prevent it from exceeding the procs limits, but it will *not*
>completely stop it.

What if the few procs that he may spawn also grab so much memory so your 
machine disappears in swap-t(h)rashing?

>The only way to kill it off successfully is to killall
>-9 the script name repeatedly.

As said earlier, killall -STOP first
=> keeps the number of processes constant (so he can't spawn any new ones)

>Of course, you should always use a bat on the user if nothing else works. ;)

Use a keylogger if you distrust, and after a bombing,
look who set us up the bomb.



Jan Engelhardt
-- 
