Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281281AbRKETKa>; Mon, 5 Nov 2001 14:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281282AbRKETKV>; Mon, 5 Nov 2001 14:10:21 -0500
Received: from scully-a0.index.hu ([217.20.130.10]:7940 "HELO dap.index")
	by vger.kernel.org with SMTP id <S281281AbRKETKA>;
	Mon, 5 Nov 2001 14:10:00 -0500
Date: Mon, 5 Nov 2001 20:09:58 +0100 (CET)
From: PALLAI Roland <dap@omnis.hu>
X-X-Sender: <dap@dap.index>
To: <linux-kernel@vger.kernel.org>
Subject: kernel oops on "hdparm -R"
Message-ID: <Pine.LNX.4.33.0111051847030.719-100000@dap.index>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 When I try to add a new IDE disk to the channel 1 with the command
"hdparm -R 0x170 0 0 /dev/hda", I've got a kernel oops (and freeze)..
It's works fine _once_, if there wasn't any detected disk on channel
before.

my config:
 kernel 2.4.9 - 2.4.14pre7 (I've tried many of them)
 PIIX and VIA motherboards (shows same error)


--
  DaP


