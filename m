Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315829AbSEJILZ>; Fri, 10 May 2002 04:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315830AbSEJILY>; Fri, 10 May 2002 04:11:24 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:14576 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S315829AbSEJILX>; Fri, 10 May 2002 04:11:23 -0400
Message-ID: <3CDB8092.8090007@wanadoo.fr>
Date: Fri, 10 May 2002 10:10:58 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.15 hangs at partition check
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PIII / Abit BE6 HPT366, devfs.

2.5.15 doesn't boot, the last lines are :

hde: 20005650 sectors w/512KiB Cache, CHS=19846/16/63, UDMA(66)
hdg: 6250608 sectors w/478KiB Cache, CHS=11024/9/63, UDMA(33)
Partition check:
  /dev/ide/host2/bus0/target0/lun0:

2.5.14 works, it gives :
hde: 20005650 sectors w/512KiB Cache, CHS=19846/16/63, UDMA(66)
hdg: 6250608 sectors w/478KiB Cache, CHS=11024/9/63, UDMA(33)
Partition check:
  /dev/ide/host2/bus0/target0/lun0: [PTBL] [1245/255/63] p1 p2 p3 p4
  /dev/ide/host3/bus0/target0/lun0: p1


-- 
Pierre
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

