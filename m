Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVCNPr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVCNPr5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVCNPr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:47:57 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:14947 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261552AbVCNPr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:47:56 -0500
Message-ID: <4235B229.9080507@prairienet.org>
Date: Mon, 14 Mar 2005 09:47:53 -0600
From: Pat Kane <pat@prairienet.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: bug in kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran the little test program on my 2.4.26  Knoppix system, and got the 
following two results:

  strace a.out < /dev/tty
   ...
   read(0, NULL, 6)                        = 1
   ...

  strace a.out < /dev/zero
   ...
   read(0, 0, 6)                           = -1 EFAULT (Bad address)
   ...

The first case looks broken.

Pat
---



