Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbULPGpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbULPGpr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 01:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbULPGpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 01:45:46 -0500
Received: from web53305.mail.yahoo.com ([206.190.39.234]:21637 "HELO
	web53305.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262623AbULPGpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 01:45:38 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=cONyJpuQR5iOowKp33LaqPoZhyvZlLE5KKOra4+38Qh6/+MN82oPAnE21zDoMGsdzkQwEsnh3MkMlfzXbJIRdWbwRpxujLJwZGxSN0Wji/imTrlqLDEYTCKgXT48cXvrLW3GTMSVB7FGGxpXstWbPXgVPIveqwQtUu6Nyg1bPVY=  ;
Message-ID: <20041216064538.93385.qmail@web53305.mail.yahoo.com>
Date: Wed, 15 Dec 2004 22:45:38 -0800 (PST)
From: firnnauriel <rinoa012000@yahoo.com>
Subject: bcopy's performance on 2.4.20 (Redhat) and 2.40.20-8um (UML)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to all! I would like to ask for your advice
regarding this question:
 "In general, is the memcpy"s performance on UML (User
 Mode Linux) environment better than the host OS? If
 that is the case, can you give the reason behind it
 (ex. UML"s architecture)?"
 
 Here"s the evironment:
 HOST
 OS: Redhat 9 (kernel 2.4.20-8)
 Brand/Model: Dell PowerEdge 2600
 CPU: Intel Xeon 2.4 GHz
 Memory: 2 GB
 Disk Space: 73 GB
 
 UML
 Kernel version    : 2.40.20-lsm1-8um 
 Allocated Mem     : 256MB
 
 I used lmbench-2.0.4 for the bandwith and latency
 testing. here"s the result:
 
 host
 memcpy     : 597.1  MB/s (higher is better)
 page fault : 2.00000     (smaller is better)
 
 uml
 memcpy     : 668.4
 page fault : 48.0
 
 The result in page fault might be because of low
 memory allocated in UML. But the question is, why is
 the memcpy on UML (668.4 MB/s) performs faster that
 the host OS?
 
 I already asked the developer of lmbench, and he
 adviced me to ask this question to the linux kernel
 mailing list.
 
 I would really appreciate any inputs and advice.
Thank
 you!


		
__________________________________ 
Do you Yahoo!? 
Jazz up your holiday email with celebrity designs. Learn more. 
http://celebrity.mail.yahoo.com
