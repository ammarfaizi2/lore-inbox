Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267655AbTBLV2j>; Wed, 12 Feb 2003 16:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267656AbTBLV2j>; Wed, 12 Feb 2003 16:28:39 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:60600 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S267655AbTBLV2i>; Wed, 12 Feb 2003 16:28:38 -0500
Message-ID: <20030212213653.94090.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Vijayan Prabhakaran" <pvijayan@engineer.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 12 Feb 2003 16:36:53 -0500
Subject: Ordering in FAT filesystem
X-Originating-Ip: 128.105.167.48
X-Originating-Server: ws1-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
I'm working on linux FAT filesystem. I'm trying to find the order in which the FAT blocks and the data blocks are written into the disk.
 
At the level of device driver, I'm seeing that the FAT blocks are written always before the corresponding data blocks. Is this just a coincidence or is the ordering between FAT and data blocks enforced ?
 
The workload I ran creates a 10MB file by writing progressively 1 MB chunks at random intervals and then truncates the file.
 
Help appreciated.

Vijayan
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

