Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268169AbUIPPWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268169AbUIPPWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUIPPVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:21:32 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:387 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S268223AbUIPPIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:08:21 -0400
Date: Thu, 16 Sep 2004 17:08:17 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1546570702.20040916170817@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: [2.6.8.1-ck7-web100] Badness in cfq_sort_rr_list
In-Reply-To: <20040916145708.GT9106@holomorphy.com>
References: <1072359679.20040916142632@dns.toxicfilms.tv>
 <20040916125824.GD3544@suse.de> <569683048.20040916165042@dns.toxicfilms.tv>
 <20040916145708.GT9106@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Harmless you say... :-) The machine almost hardlocked. I could only
>> type my username during login and that's all.
>> Maybe it is unrelated but I will try the suggested patch.

> Please use technical terms. "almost hardlocked" is ambiguous at best.
1. While being logged in with SSH, I typed date to see the today's
date. Nothing showed up, I tried ctrl+c to break whatever might be
there to break. I tried ctrl+z to try to push the task to background.
No reponse was there.
So I tried logging once more with SSH to my account. I logged in, saw
the MOTD. Once I typed one command - ls for instance - I had the same as above.
So I was able to login with SSH.

2. When I went to the console, I saw the cfq traces. I switched to the
other tty (alt+f2) and tried to log in as root, After typing root and
pressing enter I could not log in this way as with ssh.

3. I tried alt+prn+S to sync. No effects besides the disks sync'd.
So I unmounted them (alt+prn+U) and rebooted (alt+prn+B) and
sent the traces I saw.

Anyway that does not give any clues as to the source of it. Or does
it?

--
Regards,
Maciej


