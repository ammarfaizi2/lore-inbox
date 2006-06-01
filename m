Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWFAHZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWFAHZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 03:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWFAHZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 03:25:10 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:18090 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750757AbWFAHZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 03:25:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Fo4cmG93kzt2MUpBMYV9Z069n2dFGLTEeAoa65GcFpUn5c1u5JVbyJys0nsztvzGoAJfb8VZ4V62COdCaRfj3DUHOzQuMaFen3oBuYWFKO9oxn1zOIMxQKKGjVlWHkpTVqyo3RvLy/9R7kXcSiHI6UznMOxdDYqPFoW5M/xcZkc=
Message-ID: <8bf247760606010025p38131240ia133cc3124f93bf7@mail.gmail.com>
Date: Thu, 1 Jun 2006 00:25:08 -0700
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: printk's - i dont want any limit howto?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have a driver full of printks. i am trying to understand the way
the driver functions using printks

  So, i have a situation where i want all the printk's to be printed
come whatever.


   I dont want any rate limiting or anything else that prevents from
my printks from appearing on the screen or dmesg.


 Its really confusing when only one of your printks appear and some
just dont appear even though you expect them to appear.



  Is there any way to make all the printks to appear come what may?.
If so, how do  i do it?.


  Went through the printk.c am not sure setting the
printk_ratelimit_jiffies = 0 and printk_ratelimit_burst= 1000 will do?

  am not sure if printk_ratelimit_jiffies = 0 is valid.


please advice.


Regards,
sriram
