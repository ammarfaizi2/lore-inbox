Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310547AbSCLK6A>; Tue, 12 Mar 2002 05:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310515AbSCLK5u>; Tue, 12 Mar 2002 05:57:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290827AbSCLK5h>; Tue, 12 Mar 2002 05:57:37 -0500
Subject: Re: [bkpatch] Multiple threads in core dumps (was: Re: Thread
To: tachino@jp.fujitsu.com (Tachino Nobuhiro)
Date: Tue, 12 Mar 2002 11:11:52 +0000 (GMT)
Cc: dan@debian.org (Daniel Jacobowitz),
        vamsi_krishna@in.ibm.com (Vamsi Krishna S.), torvalds@transmeta.com,
        jefreyr@pacbell.net (Jeff Jenkins), linux-kernel@vger.kernel.org
In-Reply-To: <eliqqvfh.wl@nisaaru.dvs.cs.fujitsu.co.jp> from "Tachino Nobuhiro" at Mar 12, 2002 01:09:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kkC8-0003QG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am now trying to implement gcore system call on linux and have a 
> great interest in your patch.

The old Berkeley gcore wasnt a system call nor did it need to be. Ptrace
(and in their case grovelling around in /dev/mem) is more than sufficient
