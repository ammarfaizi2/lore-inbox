Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270215AbRHGO35>; Tue, 7 Aug 2001 10:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270218AbRHGO3r>; Tue, 7 Aug 2001 10:29:47 -0400
Received: from acmex.gatech.edu ([130.207.165.22]:27534 "EHLO acmex.gatech.edu")
	by vger.kernel.org with ESMTP id <S270215AbRHGO3h>;
	Tue, 7 Aug 2001 10:29:37 -0400
Message-Id: <5.1.0.14.2.20010807103637.00a88b60@pop.prism.gatech.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 07 Aug 2001 10:37:57 -0400
To: linux-kernel@vger.kernel.org
From: David Maynor <david.maynor@oit.gatech.edu>
Subject: encrypted swap
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >This is nonsense.  Of course the computer can do this.  This is exactly 
what we
 >already do for TCP sequence numbers, disk UUIDS, and many other things.
 >Granted, we need a little more initial entropy, but the principle has already
 >been established.

 >Remember that this is not the same as a crypted filesystem in that no user
 >(even root) need ever have any access to the key.  That's important.  Because
 >the swapspace is essentially wiped at powerup, the system can happily gen 
a new
 >key every boot, crypt away and never let the users know the key at all.

This is a should-if debate, in my opinion. That is, not if you can do it, 
but should you. Has anybody thought of the performance hit that you would 
take encrypting your swap?

David Maynor

