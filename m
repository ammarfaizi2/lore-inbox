Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137153AbRAHHM5>; Mon, 8 Jan 2001 02:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137169AbRAHHMm>; Mon, 8 Jan 2001 02:12:42 -0500
Received: from ifw.schulergroup.com ([194.123.83.174]:13077 "EHLO
	ifw.schuler.de") by vger.kernel.org with ESMTP id <S137153AbRAHHM2>;
	Mon, 8 Jan 2001 02:12:28 -0500
Message-Id: <200101080712.IAA13788@gatekeeper.schuler.de>
From: "Rainer Tammer" <kernel@tammer.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 08 Jan 2001 08:12:39 +0100
Reply-To: "Rainer Tammer" <kernel@tammer.net>
X-Mailer: PMMail 2000 Professional (2.10.2010) For Windows NT (4.0.1381;6)
In-Reply-To: <20010106164303.A2834@mullein.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: PROBLEM: SCSI hangs with aic7xxx in 2.4.0 SMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 6 Jan 2001 16:43:03 -0800, mull wrote:

>On Sat, Jan 06, 2001 at 09:26:55PM -0000, Craig Freeze wrote:
>> [1.] One line summary of the problem:
>> SCSI hangs with aic7xxx in 2.4.0 SMP
>> 
>> [2.] Full description of the problem/report:
>> SCSI device errors and bus resets observed in 2.4.0 that do not occur in 
>> 2.2.13.  Sysrq keys have no effect (ie hard reset required to recover)
>> 
>I've noticed pretty much the same situation on my uniproc box, aic7xxx driver, adaptec 2940uw card since going to 2.4.0-prerelease. haven't had to hard reset, but have seen 
a LOT of scsi timeout errors. i did not notice this on 2.4.0-test12 or test13pre2. when i'm at home i'll see if i can find any pattern or more info, and also test with 2.4.0 final.
>mullein
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/
>
I have noticed nearly the same. 
When I try to backup (with BRU) from a SCSI disk to my SCSI HP DDS2 DAT the system hangs (SCSI LED on) no disc access possible.

System: 2.4.0 / 2.4.0-ac3
driver: aic7xxx from 2.4.0 and aic7xxx from adaptec (lates version)
compiler: kgcc (egcs)





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
