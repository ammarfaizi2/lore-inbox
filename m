Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVDHDiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVDHDiD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVDHDiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:38:02 -0400
Received: from web54107.mail.yahoo.com ([206.190.37.242]:3172 "HELO
	web54107.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262669AbVDHDg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:36:58 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=VBi23UAPbq+Nnh/No04zbzO2d4m7t+fEHTVPEMY8m7IdW4nHekyf1g+w5xPR5qXEVS4h11gL8BMNqUdjZv+sm5XcIcRZRpVhsfBe9q606Z9zOj2Q+eY3KyilvR0bz0EZ6PqzUtmoW4zWNQBCAYL+PxHFD8dSW5OopBHl/eNesIk=  ;
Message-ID: <20050408033658.51618.qmail@web54107.mail.yahoo.com>
Date: Thu, 7 Apr 2005 20:36:58 -0700 (PDT)
From: sai narasimhamurthy <sai_narasi@yahoo.com>
Subject: Maximum data read/writes per SCSI Command
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I wanted to increase the number of sectors that could
be requested/Written  per SCSI READ(10)/WRITE command
, and varying MAX_SECTORS in blkdev.h helped me to do
it. However I could not request more than 256 sectors
and could not write more than 1632 inspite of changing
MAX_SECTORS to higher numbers. 
(request_bufflen stands still at 835584 for every
command) 


Why is that? There is probably some other variable
that should be varied. Please let me know. 
I am working on the UNH iSCSI initiator driver , and
am on kernel 2.4.29 .  

Sai 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
