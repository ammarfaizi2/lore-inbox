Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319019AbSHTPWP>; Tue, 20 Aug 2002 11:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319070AbSHTPWP>; Tue, 20 Aug 2002 11:22:15 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:47864 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S319019AbSHTPWO>; Tue, 20 Aug 2002 11:22:14 -0400
Date: Tue, 20 Aug 2002 16:26:19 +0100
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: IDE-TNG what to do ?
From: John Jones <little.jones.family@ntlworld.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2CEAF5A2-B451-11D6-A001-00050291EC35@ntlworld.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

after reading some posts and previously trying to get a PIIX chip to 
work I have come to the following conclusion

IDE is not nice

here is my suggestion:

Leave the old drivers (or 2.4 forward port) alone and fix any bugs 
slowly massaging it to what you want

IDE-TNG should ONLY deal with Serial ATA and ONLY chipset support not 
PCI based implementations and should be a config option (keep it simple 
as possible).

this way we have a clean start with a spec and not huge amounts of 
combinations to test in the real world (so we can report those bugs 
that  a US company wont talk about for fear of litigation)
AND
we have drivers that are known to work in the real world (the 2.4 
forward port)


what do you think ?

regards

John Jones

