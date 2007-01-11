Return-Path: <linux-kernel-owner+w=401wt.eu-S1030477AbXAKNzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbXAKNzc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbXAKNzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:55:32 -0500
Received: from mx1.suse.de ([195.135.220.2]:48267 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030477AbXAKNzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:55:31 -0500
From: Andreas Schwab <schwab@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Roman Zippel <zippel@linux-m68k.org>, Andy Whitcroft <apw@shadowen.org>,
       Andrew Morton <akpm@osdl.org>, Olaf Hering <olaf@aepfle.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Jean Delvare <khali@linux-fr.org>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: .version keeps being updated
References: <20070109102057.c684cc78.khali@linux-fr.org>
	<20070109170550.AFEF460C343@tzec.mtu.ru>
	<20070109214421.281ff564.khali@linux-fr.org>
	<Pine.LNX.4.64.0701101426400.14458@scrub.home>
	<20070110181053.3b3632a8.khali@linux-fr.org>
	<Pine.LNX.4.64.0701101058200.3594@woody.osdl.org>
	<20070110193136.GA30486@aepfle.de> <20070110200249.GA30676@aepfle.de>
	<Pine.LNX.4.61.0701102352400.28885@yvahk01.tjqt.qr>
	<acfe3f410c8bae877412655797a15e17@kernel.crashing.org>
	<Pine.LNX.4.61.0701111424390.29801@yvahk01.tjqt.qr>
X-Yow: It's OBVIOUS..  The FURS never reached ISTANBUL..  You were
 an EXTRA in the REMAKE of ``TOPKAPI''..  Go home to your
 WIFE..  She's making FRENCH TOAST!
Date: Thu, 11 Jan 2007 14:55:08 +0100
In-Reply-To: <Pine.LNX.4.61.0701111424390.29801@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Thu, 11 Jan 2007 14:27:59 +0100 (MET)")
Message-ID: <jeejq1is77.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>   ../drivers/char$ objcopy -j .modinfo -O binary sonypi.ko 
>   objcopy: stvfMiji: Permission denied
>
> Why does it want to create a file there? This one works better:

objcopy works in-place when only one file argument is passed.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
