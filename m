Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbUB2QpY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 11:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbUB2QpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 11:45:24 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:28244 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262072AbUB2QpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 11:45:22 -0500
Message-ID: <404217A6.7080803@myrealbox.com>
Date: Sun, 29 Feb 2004 08:47:34 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040228
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.x]  USB Zip drive kills ps2 mouse.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could I ask anyone with a USB Zip drive and a ps2 mouse to try
to confirm this bizarre bug for me?

To reproduce it should be simple:

1)  Compile USB support as modular, *not* compiled in.

2)  The USB Zip drive *must* be plugged in during boot.
     This bug won't show if you plug in the drive later.

3)  Reboot and see if your ps2 mouse works.

Thanks!
