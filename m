Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSFCLNX>; Mon, 3 Jun 2002 07:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317379AbSFCLNW>; Mon, 3 Jun 2002 07:13:22 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:53739 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317373AbSFCLNV>; Mon, 3 Jun 2002 07:13:21 -0400
Message-ID: <3CFB4F35.1030907@wanadoo.fr>
Date: Mon, 03 Jun 2002 13:12:53 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.19-20 rootfs naming with devfs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grub requires this for being able to mount the root fs
(/dev/hde2) at boot time :

root=/dev//dev/ata/host2/bus0/target0/lun0/part2

boot fails when the prefix is different from /dev//dev/ata.

This feature was introduced in 2.5.19

Pierre
-- 
------------------------------------------------
   Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------


