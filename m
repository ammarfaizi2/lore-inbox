Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVCIFNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVCIFNi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 00:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVCIFNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 00:13:38 -0500
Received: from web53307.mail.yahoo.com ([206.190.39.236]:17839 "HELO
	web53307.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261226AbVCIFNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 00:13:36 -0500
Message-ID: <20050309051335.21714.qmail@web53307.mail.yahoo.com>
Date: Wed, 9 Mar 2005 05:13:35 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: Boot sequence of /proc filesystem
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
           I am writing some piece of code in  the
linux kernel 2.6.8 , in the files
linux-2.6.8/kernel/fork.c ( in function do_fork() )
and linux-2.6.8/kernel/exit.c ( in the function
do_exit() ).

       My objective is to execute the code immediately
after the kernel has mounted the /proc filesystem.
This is because i am creating new subdirectories in
the /proc fs.
    
      What is the checking condition i should place
inside the kernel so that i can verify that the /proc
fs has been mounted during booting and now my code can
be executed by the kernel.
    
      Is there any global variable that gets turned on
when the /proc fs is mounted during booting.
  
      Also my code should continue executing until the
/proc fs has been unmounted during shutdown process.

      It would really help me if you can suggest a
wayout.
     
Thanks in advance.
Sounak

________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/
