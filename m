Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263122AbSJBNBm>; Wed, 2 Oct 2002 09:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263123AbSJBNBl>; Wed, 2 Oct 2002 09:01:41 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:24964 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S263122AbSJBNBl> convert rfc822-to-8bit;
	Wed, 2 Oct 2002 09:01:41 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: AARGH! Please help. IDE controller fsckup
Date: Wed, 2 Oct 2002 15:16:46 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210021516.46668.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I have this cute little server with some 16 120gig IDE drives, and I've got 
some serious problems with it.

Controllers:
One onboard IDE controller (2 channels).
Two promise ATA100 (2 channels each).
One CMD649 (2 channels).

something seriously bad about the CMD649 makes Linux beleive it's the first 
controller with hd[abcd]. On these, there are two RAID-1s (/ and /var). Due 
to the fact that the box has some 1,6TB disk space, we haven't got any backup 
solution (we have an identical box in order to mirror them).

so - now - the CMD649 has suddenly begun to fail - losing contact with one or 
two drives, and I _really_ need to get what's on /data (RAID-5 on 
hd[efghijklmnop]) out. Problem is - the replacement controller I've got from 
the vendor works fine (turns up as controller 3 serving hd[mnop]). How can I 
revert this most easily to be able to boot again?

I hope this is not too off topic... Please excuse that.

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

