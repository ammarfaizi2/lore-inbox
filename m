Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbSKJWvf>; Sun, 10 Nov 2002 17:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbSKJWvf>; Sun, 10 Nov 2002 17:51:35 -0500
Received: from zork.zork.net ([66.92.188.166]:36070 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S265230AbSKJWve>;
	Sun, 10 Nov 2002 17:51:34 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4: Merge Emulex and Qlogic FC drivers ?
References: <200211102302.39468.daniel.mehrmann@gmx.de>
	<6ulm419int.fsf@zork.zork.net>
	<200211102337.17028.daniel.mehrmann@gmx.de>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: HATE SPEECH, DENIAL OF THE ANTECEDENT
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: : WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 10 Nov 2002 22:58:20 +0000
In-Reply-To: <200211102337.17028.daniel.mehrmann@gmx.de> (Daniel Mehrmann's
 message of "Sun, 10 Nov 2002 23:37:17 +0100")
Message-ID: <6uheep9gmr.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Daniel Mehrmann quotation:

> On Sunday 10 November 2002 23:14, Sean Neakums wrote:
>
>> The last time I looked at an Emulex Linux driver (for the
>> LP-7000, about six months ago), it consisted of a large
>> binary-only portion, shipped in a .a file, and the source code
>> for a shim to have the library code talk to the kernel.
>>
>> Furthermore, the driver was configured by editing a .c file and
>> rebuilding it.
>>
>> All in all, a quality experience.
>
> Mh, i have the complete source code. Only the hba access 
> for IP over FC is binary, but that`s a libary api for userland 
> tools. I only want merge the standalone driver for both products. 

My memory failed slightly: the binary-only portion is the file
SourceBuild/lpfcdriver, which is copied to SourceBuild/lpfcdriver.o
during the build.

The driver distribution I looked at was:

	http://www.emulex.com/ts/downloads/linuxfc/rel/420p/lpfc-i386.tar

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
