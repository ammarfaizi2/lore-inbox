Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUA1Jic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 04:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265881AbUA1Jic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 04:38:32 -0500
Received: from imag.imag.fr ([129.88.30.1]:45783 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S265879AbUA1Jia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 04:38:30 -0500
Message-ID: <401782AB.4090305@imag.fr>
Date: Wed, 28 Jan 2004 10:36:43 +0100
From: Raphael Jacquot <raphael.jacquot@imag.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Machine check exception event
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this morning when I got to work, I had :

Message from syslogd@raph at Wed Jan 28 01:41:32 2004 ...
raph kernel: Bank 1: 9000000000000171
Message from syslogd@raph at Wed Jan 28 01:41:32 2004 ...
raph kernel: MCE: The hardware reports a non fatal, correctable incident 
occurred on CPU 0.

using the
http://www.kernel.org/pub/linux/kernel/people/davej/tools/parsemce.c
program, I got the following :

[sxpert@raph compile]$ ./parsemce  -e 9000000000000171
Status: (9000000000000171) Restart IP valid.

what does that mean ?

running kernel 2.6.1 on a duron 1100, Leadtek K7NCR18G PRO mother board 
(Nforce2)

sincerely

Raphael

