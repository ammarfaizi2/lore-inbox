Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264467AbTL0Oeg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 09:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTL0Oeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 09:34:36 -0500
Received: from dns13.mail.yahoo.co.jp ([210.81.151.173]:40323 "HELO
	dns13.mail.yahoo.co.jp") by vger.kernel.org with SMTP
	id S264467AbTL0Oef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 09:34:35 -0500
X-Apparently-From: <xxtsuchiyaxx@yahoo.co.jp>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E4E4EAA7-3879-11D8-8822-00039341E01A@ybb.ne.jp>
Content-Transfer-Encoding: 7bit
Cc: dlion2004@sina.com.cn
From: Tsuchiya Yoshihiro <xxtsuchiyaxx@ybb.ne.jp>
Subject: Re: filesystem bug?
Date: Sat, 27 Dec 2003 23:35:18 +0900
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.609)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

 >1. some corrupted files is truncated to 0 bytes. Blockcount is 0.
 >
 >2. some corrupted files is truncated . the result is a shorter file.
 >the new size is multiple of block size.

I have seen these things before, though

 >3. maybe all corrupted files' mtime is exactly the same
 >wrong value. Should be around 2003.12.26 21:30:00, but
 >is 2002.05.12 12:00:48(hex value is 0x3cdde8f0) . ctime
 >and atime is correct. The system's clock time is unchanged.
 >
 >4. it seems that the corrupted files tends to exist in the same
 >directory.

I haven't been aware of these ones. Thank you.

Yoshi
---
Yoshihiro Tsuchiya 

