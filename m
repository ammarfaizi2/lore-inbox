Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290641AbSA3WDa>; Wed, 30 Jan 2002 17:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290645AbSA3WDZ>; Wed, 30 Jan 2002 17:03:25 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:41449 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S290641AbSA3WDI>; Wed, 30 Jan 2002 17:03:08 -0500
Message-ID: <3C586D98.5090900@nyc.rr.com>
Date: Wed, 30 Jan 2002 17:03:04 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.3 Link Error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

         -o vmlinux
fs/fs.o: In function `cap_info_llseek':
fs/fs.o(.text+0x4e1d1): undefined reference to `lock_kernel'
fs/fs.o(.text+0x4e220): undefined reference to `unlock_kernel'
fs/fs.o: In function `hdr_llseek':
fs/fs.o(.text+0x4e858): undefined reference to `lock_kernel'
fs/fs.o(.text+0x4e8b6): undefined reference to `unlock_kernel'
make: *** [vmlinux] Error 1

