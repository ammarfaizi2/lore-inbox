Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269668AbRHICog>; Wed, 8 Aug 2001 22:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269669AbRHICo0>; Wed, 8 Aug 2001 22:44:26 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:43241 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S269668AbRHICoQ>; Wed, 8 Aug 2001 22:44:16 -0400
Date: Thu, 09 Aug 2001 11:45:00 +0900
From: y-goto@jp.fujitsu.com (Yasunori GOTO)
Subject: file access log
To: linux-kernel@vger.kernel.org
Message-id: <0GHS003EV4XX9D@fjmail504.fjmail.jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: Message Editor Version 2.2.6
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

I want to make the function which check the file access 
(create(), unlink(), and rename(), etc.)  
and take the log. 

When succeeding in the file access or becoming permission error,
 kernel gathers the log. 
Then,the security of Linux will improve. 

(For example, by recording the access of files in /etc directory by this function;
 The system administrator can understand a bad user to operate.)

I am examining how to make it now. 

Basic concepts are as follows. 
  - I think that the layer of access check is VFS in the kernel. 
  - Information on the access check is written in the buffer in kernel,
     and the record is taken out from kernel buffer by logging daemon. 
  - I will make the tool which retrieves and displays the gathered log later. 

Thanks.

--------------------------------------
  Yasunori Goto
    Development Department 2  
    Basis Software Division
    Software Group      
    FUJITSU LIMITED
    E-mail: y-goto@jp.fujitsu.com


