Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbVBYRSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVBYRSg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 12:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVBYRSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 12:18:33 -0500
Received: from lantana.tenet.res.in ([202.144.28.166]:2981 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S262761AbVBYRRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 12:17:33 -0500
Date: Fri, 25 Feb 2005 22:47:43 +0530 (IST)
From: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: call_usermodehelper hang
Message-ID: <Pine.LNX.4.60.0502252238190.8639@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hai all,
    I want to call a user program(script) from linux kernel.
I am using Redhat linux 9( kernel version 2.4.20-8). With the help of 
call_usermodehelper I am calling the user level program from one of the 
kernel driver. I am setting the parameters correctly.
   int call_usermodehelper(char *path, char *argv, char *envp);

  The system is hanging after giving a call trace and the error
    Code:
   <0> Kernel Panic : Aiee,Killing interrupt handler
         In interrupt handler- not syncing.

Any help is welcome.



   Thanks&Regards,

   P.Manohar.

