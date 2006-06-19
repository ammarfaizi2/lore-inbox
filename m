Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWFSJaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWFSJaP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 05:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWFSJaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 05:30:14 -0400
Received: from wr-out-0304.google.com ([64.233.184.215]:3658 "EHLO
	wr-out-0304.google.com") by vger.kernel.org with ESMTP
	id S1751239AbWFSJaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 05:30:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:message-id:user-agent:x-http-useragent:mime-version:content-type;
        b=TKGFkQQ2dKLO9ohd2MMgrGamrfDr4ojppm7Wo+MQbQHL8OEcW6l/2R9Kh+u/1Ct8fn5flgDgtKfEfPqpmuZRcZloxUDhL4Kw1rcOqXnudrZvzJsirDYxiH8Fd4pHha/ua3hOpu0FG7zxm2OwV1HoHitnHvre56nVrUbNzO3c27w=
From: "leo.liang.chen@gmail.com" <leo.liang.chen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Newbie questions on the kernel programming
Date: Mon, 19 Jun 2006 09:30:12 -0000
Message-ID: <1150709412.051278.100900@g10g2000cwb.googlegroups.com>
User-Agent: G2/0.2
X-HTTP-UserAgent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322),gzip(gfe),gzip(gfe)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am learning linux kernel programming starting from  "The Linux Kernel
Module Programming Guide"(http://www.faqs.org/docs/kernel/) .   I have
background in Windows DDK, but I am confused on the following topics.
Can anyone here give me some hints.

1) MODULE_PARM() macro (http://www.faqs.org/docs/kernel/x350.html)
static short int myshort = 1;
static int myint = 420;
static long int mylong = 9999;
static char *mystring = "blah";

MODULE_PARM (myshort, "h");
MODULE_PARM (myint, "i");
MODULE_PARM (mylong, "l");
MODULE_PARM (mystring, "s");

In the sample code, it is said the MODULE_PARM macro can allow
arguments to be passed to the driver module.  But how?

2) Character Device Drivers(http://www.faqs.org/docs/kernel/x571.html)
I can not catch the key points in this section.  What should I learn
from the "chardev.c" sample?  How can I install the module as a device?
 How can I call the functions in the driver?

3)  The /proc File System(http://www.faqs.org/docs/kernel/x716.html)
What's the main points in the section.  How does the /proc file system
matter linux kernel programming?
 
 
Many thanks!
 
Liang Chen

