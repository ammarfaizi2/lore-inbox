Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbTHQMfb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 08:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269509AbTHQMfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 08:35:31 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:50882 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S269321AbTHQMf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 08:35:27 -0400
Message-ID: <3F3F782C.2030902@t-online.de>
Date: Sun, 17 Aug 2003 14:42:20 +0200
From: Dominik.Strasser@t-online.de (Dominik Strasser)
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] scsi.h uses "u8" which isn't defined.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: XHiNhmZe8eR74dtGiktidpB30LGpVB3BHP5OpZzxLc2ro3EILf73Ec
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scsi.h uses "u8" which doesn't seem to be defined.
Better use u_char.

--- linux/include/scsi/scsi.h   2003-08-17 14:36:02.000000000 +0200
+++ /tmp/scsi.h 2003-08-17 14:39:42.000000000 +0200
@@ -226,7 +226,7 @@
   * ScsiLun: 8 byte LUN.
   */
  typedef struct scsi_lun {
-       u_char scsi_lun[8];
+       u8 scsi_lun[8];
  } ScsiLun;

  /*


Dominik

