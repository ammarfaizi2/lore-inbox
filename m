Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWAZSVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWAZSVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWAZSVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:21:46 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:11430 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932391AbWAZSVp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:21:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qr3DScwjmhDrhyfGqcaajiVXKpa7g0KL09teXxsH0BGd/SelUWY7+uUe0x6tSE5r+1jnCcD0wHWqsU+HZh2j4F6eDdLwmT931OmLSv9LAYpgQVJJySbhRyoZdLL2hStc5FfPcT8q9wUny+uXYax0VhBQKBVV5Hjxa65T/heG/RU=
Message-ID: <aa4c40ff0601261021m1fe746feq172f0a34b6afd9ad@mail.gmail.com>
Date: Thu, 26 Jan 2006 10:21:44 -0800
From: James Lamanna <jlamanna@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: I/O errors while dding between 2 SATA drives
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I received the following errors while executing a
dd if=/dev/sdb of=/dev/sda bs=1M
between 2 500GB SATA Seagate Barracuda drives on 2.6.12 (Gentoo 2005.1
"Live" CD)

ata1: command 0x35 timeout stat 0xd1 host_stat 0x21
ata1: status=0xd1 { Busy }
end request: I/O Error dev sda, sector 51188392
Buffer I/O Error on device sda, logical block 6398549
lost page write due to I/O Error on sda
ATA: abnormal status 0xD1 on port 0x9F7
ATA: abnormal status 0xD1 on port 0x9F7
ATA: abnormal status 0xD1 on port 0x9F7

The message repeats every so often with the sector count increasing by
8 and logical block count increasing by 1.

Is it bad hardware? (sda is brand new)
And is the copy hosed?

Thanks.

-- James
