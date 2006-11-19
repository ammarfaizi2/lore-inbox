Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933041AbWKSTQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933041AbWKSTQU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933042AbWKSTQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:16:20 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:5340 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S933041AbWKSTQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:16:19 -0500
Date: Sun, 19 Nov 2006 20:15:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Willy Tarreau <w@1wt.eu>
cc: Christian Schmidt <lkml@digadd.de>, linux-kernel@vger.kernel.org
Subject: Re: How to format a disk in an USB-Floppy-drive
In-Reply-To: <20061119184436.GC577@1wt.eu>
Message-ID: <Pine.LNX.4.61.0611192015050.6208@yvahk01.tjqt.qr>
References: <456081CE.9090205@digadd.de> <Pine.LNX.4.61.0611191925220.24349@yvahk01.tjqt.qr>
 <20061119184436.GC577@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 19 2006 19:44, Willy Tarreau wrote:
>On Sun, Nov 19, 2006 at 07:25:34PM +0100, Jan Engelhardt wrote:
>> > [~]>./scsifmt /dev/sdd fmt
>> > scsifmt: non-sense ioctl error
>> >
>> > Didn't work too well, too. Any ideas?
>> 
>> 
>> Does not mkfs suffice?
>
>No, he's talking about low-level format. This is necessary before writing
>anything on a floppy for the first time or after defects have been detected
>(remember these old ages ?).

Yeah but the scsi *disk* driver does not seem to handle *floppy* 
requests (just as it does not handle *cdrom* ioctls). I sense a Missing 
Feature here.



	-`J'
-- 
