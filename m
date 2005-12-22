Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVLVQD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVLVQD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 11:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbVLVQD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 11:03:57 -0500
Received: from 210-194-250-142.rev.home.ne.jp ([210.194.250.142]:16824 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964846AbVLVQD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 11:03:57 -0500
Date: Fri, 23 Dec 2005 01:03:50 +0900 (JST)
Message-Id: <20051223.010350.1300531784.whatisthis@jcom.home.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: [x86_64] Couldn't load firmware compiling with gcc-4.0
From: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
X-Mailer: Mew version 4.2.53 on Emacs 22.0.50 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I built kernel 2.6.15-rc6 with gcc-4.0 , and I built ivtv 0.5
 svn r3019 ( http://www.ivtvdriver.org/ ).
When loading ivtv module with firmware (placed at /lib/firmware ),
it seems to succeeed,but not was loaded to device 
(Connexant CX23416 MPEG Encoder).
So, I tested kernel 2.6.15-rc5 and ivtv built with gcc-4.0, 
success to load  firmware correct.

And, I built 2.6.15-rc6 and ivtv with gcc-3.4 again,loading
firmware was successed.

Refered version of gcc was:
GCC 4.0 :
>gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)

GCC 3.4 :
>gcc version 3.4.5 (Debian 3.4.5-1)

Pls.help....

Ohta
