Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUHaIFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUHaIFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267346AbUHaIFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:05:20 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:28648 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S267326AbUHaIFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:05:12 -0400
Message-ID: <41343136.6080208@free.fr>
Date: Tue, 31 Aug 2004 10:05:10 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc1-mm2 : compilation error in kernel/wait.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/wait.c:156: error: conflicting types for '__wait_on_bit'
include/linux/wait.h:143: error: previous declaration of '__wait_on_bit' 
was here
kernel/wait.c:156: error: conflicting types for '__wait_on_bit'
include/linux/wait.h:143: error: previous declaration of '__wait_on_bit' 
was here
kernel/wait.c:170: error: conflicting types for '__wait_on_bit_lock'
include/linux/wait.h:144: error: previous declaration of 
'__wait_on_bit_lock' was here
kernel/wait.c:170: error: conflicting types for '__wait_on_bit_lock'
include/linux/wait.h:144: error: previous declaration of 
'__wait_on_bit_lock' was here
make[2]: *** [kernel/wait.o] Error 1
make[1]: *** [kernel] Error 2

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



