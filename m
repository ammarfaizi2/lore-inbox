Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267289AbTAKR12>; Sat, 11 Jan 2003 12:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267299AbTAKR12>; Sat, 11 Jan 2003 12:27:28 -0500
Received: from f122.law8.hotmail.com ([216.33.241.122]:26125 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267289AbTAKR12>;
	Sat, 11 Jan 2003 12:27:28 -0500
X-Originating-IP: [24.44.249.150]
From: "sean darcy" <seandarcy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.55 ide-scsi   scheduling while atomic!
Date: Sat, 11 Jan 2003 12:36:09 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F122GQmzUptr3rXT1500001b366@hotmail.com>
X-OriginalArrivalTime: 11 Jan 2003 17:36:10.0282 (UTC) FILETIME=[EDEE68A0:01C2B997]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.5.55 ( and .54) I've enabled scsi host emulation built in the kernel. 
When I boot up with hdc=ide-scsi , it fails as it loads ide-scsi

scsi0: scsi host adapter emulation
VENDOR
TYPE       [ it recognizes my sony cdrw, then hangs for a bit then ...]
ide-scsi: abort called for 2
bad: scheduling while atomic!

It then does a series of call traces, repeating the "scheduling while 
atomic" message.







_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

