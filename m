Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTJPQEQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 12:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTJPQEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 12:04:16 -0400
Received: from ANancy-107-1-1-82.w80-13.abo.wanadoo.fr ([80.13.23.82]:14599
	"EHLO xiii.freealter.fr") by vger.kernel.org with ESMTP
	id S263009AbTJPQEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 12:04:13 -0400
Message-ID: <3F8EC144.7000005@linbox.com>
Date: Thu, 16 Oct 2003 18:03:16 +0200
From: Ludovic Drolez <ludovic.drolez@linbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030625
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0t7: /proc/partitions names not devfs like...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I'm using devfs on a small 2.6.0t7 kernel and I have software which relies on
the exactitude of /proc/partitions.
The problem is that in /proc/partition I have something like

   3     0   19925880 hda
   3     1   19920568 hda1

where a 2.4.x kernel gave me:

   3     0   19925880 ide/host0/bus0/target0/lun0/disc
   3     1   19920568 ide/host0/bus0/target0/lun0/part1

I've enabled the following options:

CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y

Any idea, why this has changed ?

Cheers,

-- 
Ludovic DROLEZ                                       Free&ALter Soft
152, rue de Grigy - Technopole Metz 2000                  57070 METZ
tel : 03 87 75 55 21                            fax : 03 87 75 19 26

