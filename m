Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131431AbRBQBZK>; Fri, 16 Feb 2001 20:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131420AbRBQBZA>; Fri, 16 Feb 2001 20:25:00 -0500
Received: from jalon.able.es ([212.97.163.2]:11971 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131400AbRBQBYo>;
	Fri, 16 Feb 2001 20:24:44 -0500
Date: Sat, 17 Feb 2001 02:24:36 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Wolfgang Teichmann <wal_teichmann@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.0/1/1-ac15 and ncr53c810a
Message-ID: <20010217022436.A968@werewolf.able.es>
In-Reply-To: <3A8DCE7D.3747DB41@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A8DCE7D.3747DB41@t-online.de>; from wal_teichmann@t-online.de on Sat, Feb 17, 2001 at 02:06:05 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.17 Wolfgang Teichmann wrote:
> Hello,
> 
> I have problems using my scanner (HP C6270A connected to ncr53c810a)
> with xsane.
> 
> I always get the error message:
> 
> error during read: Error during device I/O
> 
> 
> Feb 15 23:57:27 localhost kernel: Attached scsi generic sg2 at scsi0,
> channel 0, id 4, lun 0, type 3

Try disabling 'Initiate sync negotitation' in the card BIOS for the ID of
the scanner.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac14 #1 SMP Thu Feb 15 16:05:52 CET 2001 i686

