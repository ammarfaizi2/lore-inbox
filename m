Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbUCBQMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 11:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUCBQMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 11:12:46 -0500
Received: from web20909.mail.yahoo.com ([216.136.226.231]:51209 "HELO
	web20909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261702AbUCBQMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 11:12:43 -0500
Message-ID: <20040302161239.79676.qmail@web20909.mail.yahoo.com>
Date: Tue, 2 Mar 2004 08:12:39 -0800 (PST)
From: Anonymous <anon78344@yahoo.com>
Subject: init dies after reboot
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I encountered a strange problem, and i'm not sure that
it originates or not in the kernel.
the probl. is that on many slack boxes init dies after
some time, but the OS is still up and running.
if I 'ps aux' the machine,no init, and /proc/1 doesn't
exist.
although, `lsof | grep init` shows:init          1  
root  cwd    DIR        8,3        472         2 /
init          1   root  rtd    DIR        8,3       
472         2 /
init          1   root  txt    REG        8,3    
468916     15607 /sbin/init
init          1   root    0r   CHR        1,3         
       5659 /dev/null
init          1   root    1u   CHR        1,3         
       5659 /dev/null
init          1   root    2u   CHR        1,3         
       5659 /dev/null
init          1   root   10u  FIFO        8,3         
     137774 /dev/initctl


Any kind of ideea?

Thanks,
Uwe Bower



__________________________________
Do you Yahoo!?
Yahoo! Search - Find what you’re looking for faster
http://search.yahoo.com
