Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317673AbSGUJIp>; Sun, 21 Jul 2002 05:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317674AbSGUJIp>; Sun, 21 Jul 2002 05:08:45 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:30090 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317673AbSGUJIo>; Sun, 21 Jul 2002 05:08:44 -0400
Message-ID: <3D3A7AB2.6070503@wanadoo.fr>
Date: Sun, 21 Jul 2002 11:11:14 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020719
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Greg KH <greg@kroah.com>
Subject: 2.5.27 uhci-hcd not so bad with Speedtouch
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Speedtouch usb modem works fine with the 2.5.27 uhci-hcd module when 
it doesn't with 2.5.25

The driver is the same except removing 4 instances of USB_QUEUE_BULK. 
The kernel is without devfs because it's broken (unrelated I think).

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

