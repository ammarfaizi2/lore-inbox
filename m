Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVCUC0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVCUC0I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 21:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVCUC0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 21:26:08 -0500
Received: from relay01.pair.com ([209.68.5.15]:44552 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S261454AbVCUC0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 21:26:07 -0500
X-pair-Authenticated: 24.126.76.52
Message-ID: <423E238F.3030805@kegel.com>
Date: Sun, 20 Mar 2005 17:29:51 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible;MSIE 5.5; Windows 98)
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: jbglaw@lug-owl.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.11.3 build problem in arch/alpha/kernel/srcons.c with gcc-4.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone with an alpha care to suggest a fix for this?

arch/alpha/kernel/srmcons.c: In function 'srmcons_open':
arch/alpha/kernel/srmcons.c:196: warning: 'srmconsp' may be used uninitialized in this function
make[1]: *** [arch/alpha/kernel/srmcons.o] Error 1
make: *** [arch/alpha/kernel] Error 2

I get this when building the 2.6.11.3 kernel with a recent gcc-4.0 snapshot.

Thanks,
Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html

