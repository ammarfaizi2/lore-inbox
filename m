Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbSJTJht>; Sun, 20 Oct 2002 05:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbSJTJhc>; Sun, 20 Oct 2002 05:37:32 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:16390 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S263362AbSJTJau>; Sun, 20 Oct 2002 05:30:50 -0400
From: "Helge Hafting" <helgehaf@idb.hist.no>
Date: Sun, 20 Oct 2002 11:37:18 +0200
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.43 smp bootup crash, more info - probably scsi/raid
Message-ID: <20021020093718.GA6990@hh.idb.hist.no>
References: <3DAE605F.3B744FFC@broadpark.no> <3DAE8E90.D3E7CACF@aitel.hist.no> <aos5o9$rt8$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aos5o9$rt8$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 05:45:45PM +0000, bill davidsen wrote:
> In article <3DAE8E90.D3E7CACF@aitel.hist.no>,
> Helge Hafting  <helgehaf@aitel.hist.no> wrote:
[...]
> | The problem affects both 2.5.43 and 2.5.43-mm2.
> 
> Is it an OOPS or just a BUG? I got a BUG until I applied the patch, now
> my SCSI devices don't actually work, but I don't get an OOPS.

Hard to say - the first part scrolls off screen immediately, then
the machine hangs. All I see is the last part of a
backtrace and a machine that don't respond to anything but the
reset and power switches. 

This is fixed in 2.5.44 though, there were some known issues with 
the md driver and vfs.

Helge Hafting


