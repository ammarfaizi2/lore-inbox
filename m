Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131090AbQKXOT3>; Fri, 24 Nov 2000 09:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131148AbQKXOTX>; Fri, 24 Nov 2000 09:19:23 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:58887 "EHLO mailhost.tue.nl")
        by vger.kernel.org with ESMTP id <S131179AbQKXOGK>;
        Fri, 24 Nov 2000 09:06:10 -0500
Message-ID: <20001124143557.A5614@win.tue.nl>
Date: Fri, 24 Nov 2000 14:35:57 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Ion Badulescu <ionut@cs.columbia.edu>,
        "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <3A1DFDED.1C37EA7C@haque.net> <Pine.LNX.4.21.0011240047520.16450-100000@age.cs.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0011240047520.16450-100000@age.cs.columbia.edu>; from Ion Badulescu on Fri, Nov 24, 2000 at 12:51:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2000 at 12:51:05AM -0800, Ion Badulescu wrote:

> Ok. Are there any IDE-related errors in your logs

Once, after a reboot:

Nov 22 17:25:50 mette kernel: hdf: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Nov 22 17:25:50 mette kernel: hdf: drive not ready for command
Nov 22 17:25:50 mette kernel: hdf: status timeout: status=0xd0 { Busy }
Nov 22 17:25:50 mette kernel: hdf: drive not ready for command
Nov 22 17:25:52 mette kernel: ide2: reset: success

(But I described the situation where the data on disk was correct
and the date in core was not - almost certainly this is not an IDE problem.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
