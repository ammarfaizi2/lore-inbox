Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318933AbSIKNcm>; Wed, 11 Sep 2002 09:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318948AbSIKNcm>; Wed, 11 Sep 2002 09:32:42 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:59344 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S318933AbSIKNcl>; Wed, 11 Sep 2002 09:32:41 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-preX-acX block device question
Date: Wed, 11 Sep 2002 16:37:27 +0300
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209111637.27113.nahshon@actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using a USB-storage device, I removed the device while there is
no mounted FS on it (and to my knowledge there should not
be any dirty blocks). Yet, I observed IO error reports on shutdown.

Anything trying to access block devices on shutdown? Why?

This was observed on several 2.4.19-ac1 and 2.4.20-pre5-ac2.

Thanks,
Itai

