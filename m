Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269014AbUJKPAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269014AbUJKPAc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269049AbUJKO5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:57:52 -0400
Received: from zero.aec.at ([193.170.194.10]:2320 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S269014AbUJKO5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:57:15 -0400
To: "Harald Dunkel" <harald.dunkel@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4: Aiee on amd64
References: <2O9EX-iw-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 11 Oct 2004 16:57:10 +0200
In-Reply-To: <2O9EX-iw-5@gated-at.bofh.it> (Harald Dunkel's message of "Mon,
 11 Oct 2004 16:50:07 +0200")
Message-ID: <m3lled5mm1.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Harald Dunkel" <harald.dunkel@t-online.de> writes:

> Hi folks,
>
> I installed 2.6.9-rc4 this morning, but it died at boot time
> (a lot of hex output and something about "Aiee" :-). I tried
> to redirect syslog to another host, but the error message did
> not show up in the foreign log files.
>
> Any idea how to catch this message? The problem seems to be
> reproducable, and I would be glad to help.

Use a null modem to the other system and boot with 
console=ttyS0,baudrate
Then use some logging terminal program (e.g. kermit) 
on the other side to catch the output.

Before doing this verify in a working system that the cable works.

If that is not possible you can use a digital camera in the worst
case and put the jpeg somewhere.

-Andi

