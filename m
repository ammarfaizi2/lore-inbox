Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313501AbSDQKjv>; Wed, 17 Apr 2002 06:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313507AbSDQKju>; Wed, 17 Apr 2002 06:39:50 -0400
Received: from cttsv008.ctt.ne.jp ([210.166.4.137]:48623 "EHLO
	cttsv008.ctt.ne.jp") by vger.kernel.org with ESMTP
	id <S313501AbSDQKjs> convert rfc822-to-8bit; Wed, 17 Apr 2002 06:39:48 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Gabor Kerenyi <wom@tateyama.hu>
To: linux-kernel@vger.kernel.org
Subject: offtpic: GPL driver vs. non GPL driver
Date: Wed, 17 Apr 2002 19:37:48 +0900
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200204171937.48441.wom@tateyama.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Sorry if it is a little bit offtopic. As I posted before the company I am 
working for would like me to write a linux driver. It's wunderful. But as the 
other companies it wouldn't like to publish the source code and wants to 
distribute it only in binary format.
Of course I prefer the GPL.  How can I change the company's mind about it?
I planned the driver as the following:

The DRIVER itself (handles interrupt, pci resources, memory access etc)
A LIB, used by applications. In real life it implements the functions of the 
card.

First question: Is it possible to write the driver in GPL and then develop a 
binary only LIB? (I think yes because the LIB is in user space)

The company may accept the GPL-d driver, but not the GPL-d (or LGPL-d) LIB.

What are the advantages when the driver is GPL? How can I change the company's 
mind to publish the driver in GPL? (or if someone has got idea about the LGPL 
LIB too...)

Now the driver doesn't use any GPL-only symbols...

THX

Gabor

