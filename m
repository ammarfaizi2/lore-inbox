Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbUK1RtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUK1RtZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 12:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbUK1RtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 12:49:25 -0500
Received: from main.gmane.org ([80.91.229.2]:8665 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261531AbUK1RtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 12:49:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
Date: Sun, 28 Nov 2004 17:49:12 +0000 (UTC)
Message-ID: <slrncqk3so.19r.psavo@varg.dyndns.org>
References: <33133.192.168.0.2.1101499190.squirrel@192.168.0.10> <32942.192.168.0.2.1101549298.squirrel@192.168.0.10> <slrncqhqib.19r.psavo@varg.dyndns.org> <33262.192.168.0.2.1101597468.squirrel@192.168.0.10> <slrncqjcve.19r.psavo@varg.dyndns.org> <33050.192.168.0.5.1101651929.squirrel@192.168.0.10> <20041128165257.GA26714@suse.de>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
X-Face: $sk2zxhxVp'QPUj~kr+z:<m>#+84DO\Ab{4Hes1.P>]p=XhgsnwZM^[:"M?W#_x{W5[lu7i bqv7lOL`]5G%fH"Pgd5;+t"w)sOPDg::&T$Z9p#|xSMIb`$Udj6u14lh]imQ\z
User-Agent: slrn/0.9.8.1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jens Axboe <axboe@suse.de>:
>> > I modified your speed-1.0 to open device O_RDWR, didn't help.
>> > I modified it to also dump_sense after CMD_SEND_PACKET, it's just
>> > duplicate packet.
>> 
>> No this will definitively not solve this issue. I will try to check this
>> in the kernel, but because I'm not a kernel developer I will CC Jens
>> Axboe. Maybe he can help?
>
> Just fix the permission on the special file. Additionally, the program
> must open the device O_RDWR.

(under 2.6.10-rc2-mm1)
I ran speed-1.0 program as root and also modified to open the device
file as O_RDWR. This didn't help, it still reports same error.

Booted into 2.4.28, speed-1.0 didn't do the trick there either. 'sense'
reported was 00.00.00 though.


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

