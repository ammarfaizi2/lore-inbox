Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbTAFHlQ>; Mon, 6 Jan 2003 02:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbTAFHlQ>; Mon, 6 Jan 2003 02:41:16 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:32679 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266292AbTAFHlP>; Mon, 6 Jan 2003 02:41:15 -0500
Subject: Still: swsusp in 2.5.54 BUG on kernel/suspend.c line 718
From: Carsten Rietzschel <cr@daRav.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1041839311.28111.8.camel@linux.daR.av>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 06 Jan 2003 08:48:31 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

while trying the new kernel 2.5.54 I also tried software suspend.
But 

   if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave)) /*
copy */
       BUG();

still raises BUG();

While searching the mailing list, I found this one:
http://marc.theaimsgroup.com/?l=linux-kernel&m=104099902314723&w=2
The symptoms are the same as writen there (but at another adress).

The patch provided as solution seems to be already in 2.5.54 (but I'm
not sure, because many small changes were also made).

I would like to help you with more information or testing, So let me
know.


Regards,
Carsten




