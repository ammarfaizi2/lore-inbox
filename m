Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270502AbRHHPJe>; Wed, 8 Aug 2001 11:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270503AbRHHPJN>; Wed, 8 Aug 2001 11:09:13 -0400
Received: from acmey.gatech.edu ([130.207.165.23]:720 "EHLO acmey.gatech.edu")
	by vger.kernel.org with ESMTP id <S270502AbRHHPJJ>;
	Wed, 8 Aug 2001 11:09:09 -0400
Message-Id: <5.1.0.14.2.20010808111228.00a83720@pop.prism.gatech.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 08 Aug 2001 11:17:36 -0400
To: linux-kernel@vger.kernel.org
From: David Maynor <david.maynor@oit.gatech.edu>
Subject: encrypted swap(beating a dead horse)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>>2.  anyone stealing a disk to get data out of it sure as hell isn't going
>>to boot it up and run your init scripts.

This is true, so the best thing for this, in my opinion, instead of 
throwing the crypto blanket over everything, scrub the swap when a process 
is terminated so when the machine is shut down, you won't have to clean the 
entire swap.





