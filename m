Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315336AbSDWTt3>; Tue, 23 Apr 2002 15:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSDWTt0>; Tue, 23 Apr 2002 15:49:26 -0400
Received: from smtp-out-7.wanadoo.fr ([193.252.19.26]:43749 "EHLO
	mel-rto7.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S315336AbSDWTtZ>; Tue, 23 Apr 2002 15:49:25 -0400
Message-ID: <3CC5BAA3.3080705@wanadoo.fr>
Date: Tue, 23 Apr 2002 21:48:51 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.9 - HPT366 ide unexpected interrupts
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PIII 650/Abit BE6 HPT366(ide2, ide3)

dmesg gives 482 times the same line :
ide: unexpected interrupt 0 11

sylogd logs the same :
ide: unexpected interrupt 0 11
last message repeated 1820 times
last message repeated 4251 times
last message repeated 272 times
last message repeated 69 times

# cat /proc/interrupts
            CPU0
   0:     166782          XT-PIC  timer
   1:       6631          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   8:          0          XT-PIC  rtc
   9:       4456          XT-PIC  Ensoniq AudioPCI, usb-uhci
  10:          0          XT-PIC  eth0
  11:      10854          XT-PIC  ide2, ide3
  12:      30840          XT-PIC  PS/2 Mouse
  15:          1          XT-PIC  ide1
NMI:          0
LOC:     166737
ERR:          0


Pierre
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

