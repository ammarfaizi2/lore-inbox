Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130661AbRCFNT2>; Tue, 6 Mar 2001 08:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130775AbRCFNTS>; Tue, 6 Mar 2001 08:19:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42258 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130661AbRCFNTA>;
	Tue, 6 Mar 2001 08:19:00 -0500
Date: Tue, 6 Mar 2001 14:18:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Adrian Levi <a_levi@dingoblue.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible Bug? 2.2.18
Message-ID: <20010306141843.I2803@suse.de>
In-Reply-To: <003901c0a600$1a5d3220$0200a8c0@dingoblue.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003901c0a600$1a5d3220$0200a8c0@dingoblue.net.au>; from a_levi@dingoblue.net.au on Tue, Mar 06, 2001 at 03:41:31PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06 2001, Adrian Levi wrote:
> running 2.2.18 on a AMD486DX4 - 120 with 34Mb Ram running RH6.2 I obtained
> these errors while trying to copy files from a burnt CD.
> 
> Mar  6 10:13:33 lefty kernel: hdb: command error: status=0x51 { DriveReady
> SeekComplete Error }
> Mar  6 10:13:33 lefty kernel: hdb: command error: error=0x54
> Mar  6 10:13:33 lefty kernel: end_request: I/O error, dev 03:40 (hdb),
> sector 140520
> Mar  6 10:13:33 lefty kernel: ATAPI device hdb:
> Mar  6 10:13:34 lefty kernel:   Error: Illegal request -- (Sense key=0x05)
> Mar  6 10:13:34 lefty kernel:   Illegal mode for this track or incompatible
> medium -- (asc=0x64, ascq=0x00)
> Mar  6 10:40:57 lefty kernel: hdb: command error: status=0x51 { DriveReady
> SeekComplete Error }
> Mar  6 10:40:57 lefty kernel: hdb: command error: error=0x54
> Mar  6 10:40:57 lefty kernel: ATAPI device hdb:
> Mar  6 10:40:57 lefty kernel:   Error: Illegal request -- (Sense key=0x05)
> Mar  6 10:40:57 lefty kernel:   Illegal mode for this track or incompatible
> medium -- (asc=0x64, ascq=0x00)

This looks like you're copying from an audio or vcd track.

> The system locked hard with the drive light on, not accepting commands via
> telnet. I plugged in a Keyboard and Monitor and line after line of:
> 
> hdb: Missed Interupt   (As close as i can get via memory).

Ugh

-- 
Jens Axboe

