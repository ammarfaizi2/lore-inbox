Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVCCJuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVCCJuT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVCCJuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:50:18 -0500
Received: from mail.bencastricum.nl ([213.84.203.196]:9993 "EHLO
	bencastricum.nl") by vger.kernel.org with ESMTP id S262092AbVCCJuD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:50:03 -0500
Message-ID: <002001c51fd6$32c74630$0602a8c0@links>
From: "Ben Castricum" <lk@bencastricum.nl>
To: "Jean Delvare" <khali@linux-fr.org>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Robert Hancock" <hancockr@shaw.ca>, <khali@linux-fr.org>
References: <007801c51ddf$271d95d0$0602a8c0@links> <4225A4F6.2000106@linux-fr.org>
Subject: Re: 2.6.11-rc4 doubles CPU temperature
Date: Thu, 3 Mar 2005 10:48:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-bencastricum-MailScanner-Information: Please contact the ISP for more information
X-bencastricum-MailScanner: Found to be clean
X-MailScanner-From: lk@bencastricum.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

> If you have an Asus AS99127F chip, the value reported before in sysfs were 
> not correct, the new ones are.

This is indeed the case. To be sure I ran unixbench on rc3 and the just 
released 2.6.11 en the results were nearly identical. So the temperature 
increase does not seems to indicate that the CPU is doing more.

> 40 degrees C is a fairly reasonable temperature for a CPU diode, there's 
> nothing to be afraid of. At any rate it's more reasonable than the 
> incredibly low 20 degrees C temperature you had before, as Robert Hancock 
> noticed in an earlier post.

Then I have proabably been measuring it wrong from start. I will upgrade 
lm_sensors and try again.

Thanks,
Ben 

