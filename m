Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289833AbSBOO5V>; Fri, 15 Feb 2002 09:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289832AbSBOO5K>; Fri, 15 Feb 2002 09:57:10 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:18651 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S289829AbSBOO45>; Fri, 15 Feb 2002 09:56:57 -0500
Message-ID: <3C6D2130.1020103@wanadoo.fr>
Date: Fri, 15 Feb 2002 15:54:40 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.5-pre1 rmmod usb-uhci hangs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with 2.5.5-pre1 usb-uhci module can't unload. rmmod hangs, leaving the 
system unstable. in one circumstance the box freezed with an oops 
involving swapper pid0 . this doesn't happen with 2.5.4

# modprobe usb-uhci
# lsmod
usb-uhci    21924    0    (unused)
usbcore     60524    1    [usb-uhci]
# rmmod usb-uhci [hangs undefinitely in stat D]
   PID TTY      STAT   TIME COMMAND
   119 vc/1     D      0:00 rmmod usb-uhci
# lsmod
usb-uhci    0    0    (deleted)
usbcore    60524    1    [usb-uhci]

any clue ?

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

