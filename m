Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbUK2Pe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUK2Pe0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUK2Pe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:34:26 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:14588 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261731AbUK2PeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:34:07 -0500
Message-ID: <41AB4171.1020605@blueyonder.co.uk>
Date: Mon, 29 Nov 2004 15:34:09 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.8 (X11/20040914)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc2-mm3 cdrwtool errors
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Nov 2004 15:34:34.0894 (UTC) FILETIME=[EDBE8AE0:01C4D628]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide-cd and udf modules loaded. udftools-1.0.0b3 installed. On earlier 
kernels this used to work.

  # cdrwtool  -d /dev/hdc -q
using device /dev/hdc
1400KB internal buffer
setting write speed to 12x
Settings for /dev/hdc:
         Fixed packets, size 32
         Mode-2 disc

I'm going to do a quick setup of /dev/hdc. The disc is going to be 
blanked and formatted with one big track. All data on the device will be 
lost!! Press CT
RL-C to cancel now.
ENTER to continue.

Initiating quick disc blank
wait_cmd: Input/output error
Command failed: a1 01 00 00 00 00 00 00 00 00 00 00 - sense 02.30.00
blank disc: Illegal seek

 From /var/log/messages
Nov 29 15:07:34 Boycie kernel: cdrom: This disc doesn't have any tracks 
I recognize!
Nov 29 15:08:08 Boycie kernel: cdrom: This disc doesn't have any tracks 
I recognize!
Nov 29 15:08:44 Boycie last message repeated 2 times
Nov 29 15:09:31 Boycie cdrecord: resmgr: server response code 200
Nov 29 15:09:31 Boycie cdrecord: resmgr: server response code 200
Nov 29 15:11:56 Boycie cdrecord: resmgr: server response code 502
Nov 29 15:11:57 Boycie last message repeated 19 times
Nov 29 15:11:57 Boycie cdrecord: resmgr: server response code 501
Nov 29 15:11:57 Boycie last message repeated 5 times
Nov 29 15:13:06 Boycie kernel: cdrom: This disc doesn't have any tracks 
I recognize!
Nov 29 15:14:51 Boycie kernel: cdrom: This disc doesn't have any tracks 
I recognize!
Nov 29 15:23:58 Boycie kernel: cdrom: This disc doesn't have any tracks 
I recognize!

I don't see any activity on the drive, but it knows a cdrw is there.
Regards
Sid.
-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
