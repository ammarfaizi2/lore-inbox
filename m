Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264679AbSKUTx1>; Thu, 21 Nov 2002 14:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSKUTxA>; Thu, 21 Nov 2002 14:53:00 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:4003 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S264724AbSKUTwL> convert rfc822-to-8bit; Thu, 21 Nov 2002 14:52:11 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Matt Young <wz6b@arrl.net>
Reply-To: wz6b@arrl.net
To: linux-kernel@vger.kernel.org
Subject: Operations inside a module
Date: Thu, 21 Nov 2002 11:59:03 -0800
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211211159.03552.wz6b@arrl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Within the open routine of  my module I need to open another device; and the 
write routine needs to write to the other device.

User space system calls seem to be unavailable to module code.
I know about swapping the DS and ES to fake out other modules; then using 
sys_write etc. 

Can my code just include the standard  syscall lib and use them from kernel 
space?

My module code would also like to use user space malloc, is this a problem?

Matt

  
