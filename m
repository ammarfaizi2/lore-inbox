Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130888AbRBDWtN>; Sun, 4 Feb 2001 17:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131178AbRBDWtE>; Sun, 4 Feb 2001 17:49:04 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:59009 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131148AbRBDWsz>; Sun, 4 Feb 2001 17:48:55 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <PGEDKPCOHCLFJBPJPLNMAEHPCBAA.denali@sunflower.com> 
In-Reply-To: <PGEDKPCOHCLFJBPJPLNMAEHPCBAA.denali@sunflower.com> 
To: "Steve 'Denali' McKnelly" <denali@sunflower.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Motherboard Misdetect 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Feb 2001 22:48:47 +0000
Message-ID: <12660.981326927@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


denali@sunflower.com said:
> 	I own a M-Technology M-668DS motherboard.  Linux 2.4.1
> 	identifies my board as a Soyo SY-6KD.  They're not really
> 	the same board, and they each have features the other doesn't
> 	have. (The 668DS has onboard SCSI, where as the 6KD doesn't.
> 	The 6KD can be upgraded for I20 compatibiliy, whereas the 668DS
> 	can't.)

Linux is only reporting the information contained within the BIOS. It's not
going to cause you a problem. Other than printing it, the only thing Linux
uses the information for is to ensure that we don't lock up the machine by
trying to use certain APM functinos on certain laptops which have
known-buggy BIOSes. (You can blame Dell for this particular piece of 
incompetence).


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
