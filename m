Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267512AbUG3CDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267512AbUG3CDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 22:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265962AbUG3CDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 22:03:33 -0400
Received: from sv.sms13.de ([216.40.241.214]:50360 "HELO sv.sms13.de")
	by vger.kernel.org with SMTP id S267479AbUG3CDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 22:03:30 -0400
Date: Fri, 30 Jul 2004 04:03:21 +0200
From: MA <admin@sms13.de>
Reply-To: MA <admin@sms13.de>
X-Priority: 3 (Normal)
Message-ID: <1623453663.20040730040321@sms13.de>
To: linux-kernel@vger.kernel.org
Subject: kernel problems, crc32c
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Not sure if this is the correct place to ask, I compiled my own
kernel, nothing fancy, mostly default stuff + some additional device
drivers but after trying to load the kernel I end up with the
following error

Failed to load transform for crc32c

Testing hmac_md5 

Test 1: 
9294727a3638bb1c13f48ef8158bfc9d 
Pass 

Test 2: 
750c783e6ab0b503eaa86e310a5db738 
Pass 

Test 3: 
56be34521d144c88dbb8c733f0e8b3f6 
Pass 

Test 4: 
697eaf0aca3a3aea3a75164746ffaa79 
Pass 

Test 5: 
56461ef2342edc00f9bab995690efd4c 
Pass 

Test 6: 
6b1ab7fe4db7bf8f0b62ebce61b9d0cd 
Pass 

Test 7: 
6f630fad67cda0ee1fb1f562db63aa53e 
Pass 


AT THIS POINT IT HANGS

This is redhat enterprise 3.0, I was trying a couple 2.6.X serie
kernels and the error was the same each time, I was also trying to
exlcude crc32 options from kernel but it didnt help, I was not able to
find the resolution on google, so here I am asking for help, thanks


-- 
Sincerely MA

