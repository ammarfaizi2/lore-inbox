Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264409AbUEIWcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbUEIWcx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 18:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264404AbUEIWcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 18:32:53 -0400
Received: from mail.tpgi.com.au ([203.12.160.59]:32641 "EHLO mail3.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264409AbUEIWcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 18:32:51 -0400
Subject: Re: uspend to Disk - Kernel 2.6.4 vs. r50p
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@suse.cz>
Cc: Rob Landley <rob@landley.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040508225401.GF29255@atrey.karlin.mff.cuni.cz>
References: <20040429064115.9A8E814D@damned.travellingkiwi.com>
	 <20040503123150.GA1188@openzaurus.ucw.cz>
	 <200405042018.23043.rob@landley.net>
	 <20040508225401.GF29255@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Message-Id: <1084141917.20486.8.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-2.norlug 
Date: Mon, 10 May 2004 08:31:57 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2004-05-09 at 08:54, Pavel Machek wrote:
> Nigel's refrigerator is way more elaborate and very intrusive, but he
> seems to work *always*. Original refrigerator (shared by swsusp and
> pmdisk) only tries a bit and eventually gives up if stopping system is
> too hard. Hopefully Nigel's code can be simplified.

It's actually pretty simple. I just need to explain it more clearly.
Semaphores and wait queues seem complicated to me :>

> He's out of time, so money is not likely to help. Sending some money
> to Nigel might do the trick ;-).

Sending money to me won't help either, except with getting support for
new hardware. I'm working on finding and blatting a little but
significant bug that's made its way in since 2.0. Then I'm only going to
be working on merging.

Rob, I would concentrate on figuring out what makes Pavel's version work
for you and the other two not work. Perhaps then we can adjust our
implementations to address the issue and make you a happy camper :>

Regards,

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

