Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVAJU4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVAJU4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVAJUxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:53:30 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:6740 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262471AbVAJUwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:52:33 -0500
Message-ID: <41E2EB09.5000603@sbcglobal.net>
Date: Mon, 10 Jan 2005 15:52:25 -0500
From: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041223
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: address space reservation functionality?
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering if some functionality existed in Linux.  Specifically, 
in Solaris, you can mmap the null device in order to reserve part of the 
address space without otherwise consuming resources.  This is detailed 
in the Solaris manpage null(7D).  The same functionality is also 
available under Windows NT/XP/2K by calling the VirtualAlloc function 
with the MEM_RESERVE flag omitting the MEM_COMMIT flag.  Does Linux have 
a similar mechanism buried somewhere whereby I can reserve a part of the 
address space and not increase the "virtual size" of the process or the 
system's idea of the amount of memory in use?  I could not find one by 
using the source.

Regards,

Rob

