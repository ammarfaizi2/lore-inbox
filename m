Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752790AbWKLTIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbWKLTIv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 14:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbWKLTIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 14:08:51 -0500
Received: from web27401.mail.ukl.yahoo.com ([217.146.177.177]:56662 "HELO
	web27401.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1752790AbWKLTIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 14:08:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=27MBY1kkIpB6kABntznBRz0xYEE+8nTUom1puJiFc64U1LbMmo8ahY/Sc2ZBpcI4aUNV2y01msba5YBGysIAjNSRyv1FPIZmpGkoIMlbiprosOi+4jzmD7fxI+9g06Md8CQKSZ8qElVTVCil7hBTjkL5yLjn93hiJxM4JdZhO/k=  ;
Message-ID: <20061112190848.37896.qmail@web27401.mail.ukl.yahoo.com>
Date: Sun, 12 Nov 2006 19:08:48 +0000 (GMT)
From: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
Subject: privilege level of program which is called by call_usermodehelper()
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think  the program which is called by
call_usermodehelper() will not  be executed at
privilege level zero on IA-32 machines. 
Am I right?


How to run a program which has been compiled by a
compiler(say gcc) at privilege level zero?


Indeed I  want to compare time taken in executing two
programs. If we run them at privilege level zero by
calling them in a kernel module, processor will not
switch to other processors. So that we can find out
time taken to execute a program more accurately.

What you say??
Thanks in advance.


  


		
___________________________________________________________ 
Now you can scan emails quickly with a reading pane. Get the new Yahoo! Mail. http://uk.docs.yahoo.com/nowyoucan.html
