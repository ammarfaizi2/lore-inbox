Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283475AbRK3Cls>; Thu, 29 Nov 2001 21:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283478AbRK3Cli>; Thu, 29 Nov 2001 21:41:38 -0500
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:52231 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S283481AbRK3Cl1>;
	Thu, 29 Nov 2001 21:41:27 -0500
Message-ID: <3C06F218.4050907@si.rr.com>
Date: Thu, 29 Nov 2001 21:42:32 -0500
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.1-pre4: drivers/scsi/scsi_lib.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    I haven't seen this posted yet, so here it is..
During a 'make bzImage' for 2.5.1-pre4, I received the following error:

scsi_lib.c: In function 'scsi_io_completion'
scsi_lib.c:585: parse error before 'good_sectors'
..Error 1, in drivers/scsi

The following patch does the trick....missing comma
Regards,
Frank



