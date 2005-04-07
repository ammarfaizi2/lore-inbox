Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVDGUiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVDGUiU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 16:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVDGUiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 16:38:19 -0400
Received: from web54107.mail.yahoo.com ([206.190.37.242]:26528 "HELO
	web54107.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262594AbVDGUiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 16:38:00 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=JNJ41jhQ1x1vbt2Y+QdnSPJbpDRTJouTRmkMw8YWVjqC8cCy23ZQFJfi4zcpWh2CE4qHHRVZmJtIuGm0yh8YBJtLPUdzpQ7eC1YJz3tlmDtuBwYulwwQQ6yXlFaNlKh79PE5i/4bP/cE4W/Nh8thMTm/fIl5htrU2wI+WB6zsIk=  ;
Message-ID: <20050407203755.26507.qmail@web54107.mail.yahoo.com>
Date: Thu, 7 Apr 2005 13:37:55 -0700 (PDT)
From: sai narasimhamurthy <sai_narasi@yahoo.com>
Subject: Increasing MAX_SECTORS  in blkdev.h -2.4.29
To: linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 Hi, 
 I wanted to increase the number of sectors that
 could be requested/Written  per SCSI READ(10)/WRITE
 command , and varying MAX_SECTORS in blkdev.h helped
me to do it. However I could not request more than 256
 sectors and could not write more than 1024 inspite of
 changing MAX_SECTORS to higher numbers. 
 Why is that? There is probably some other variable
 that should be varied. Please let me know if anyone
has an idea. 
 I am working on the UNH iSCSI initiator driver , and
 am on kernel 2.4.29 .  
 
 Sai 
 
 
 
 
 		


		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 
