Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751706AbWAKRoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbWAKRoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbWAKRoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:44:07 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31141 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751706AbWAKRoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:44:05 -0500
Subject: Re: ata errors -> read-only root partition. Hardware issue?
From: Lee Revell <rlrevell@joe-job.com>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5a2cf1f60601110726r46805e1dl784f0a0ca20c128@mail.gmail.com>
References: <5ttip-Xh-13@gated-at.bofh.it> <43C4493A.4010305@shaw.ca>
	 <5a2cf1f60601110030u358c12fcscf79067cbc3eebe0@mail.gmail.com>
	 <1136986688.28616.7.camel@localhost.localdomain>
	 <5a2cf1f60601110552t5e9afa0dr7785b22ae6dbd99b@mail.gmail.com>
	 <5a2cf1f60601110726r46805e1dl784f0a0ca20c128@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 12:44:02 -0500
Message-Id: <1137001442.27255.53.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 16:26 +0100, jerome lacoste wrote:
> Could something else (bad cable or disk controller ) trigger these
> issues?
> 
> It would be great if we users had a quick way to decipher these
> messages.
> 
> E.g.
> 
> "Buffer I/O error on device xxxx, logical block yyyyyyy"
> 
> Usualy a disk failure, may also be caused by.... 

This is not a bad idea, "status=0x51 { DriveReady SeekComplete Error }"
in my experience always indicates a failing hard drive.  Maybe a
"Possible drive or media failure" could be added?

Lee

