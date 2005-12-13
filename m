Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbVLMPak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVLMPak (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbVLMPak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:30:40 -0500
Received: from mailhost.telefonica.net ([213.4.149.66]:40257 "EHLO
	ctsmtpout3.frontal.correo") by vger.kernel.org with ESMTP
	id S965002AbVLMPaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:30:39 -0500
Message-ID: <9108837.1134487799101.JavaMail.root@ctps7>
Date: Tue, 13 Dec 2005 16:29:59 +0100 (MET)
From: "KERNEL_C@telefonica.net" <KERNEL_C@telefonica.net>
Reply-To: "KERNEL_C@telefonica.net" <KERNEL_C@telefonica.net>
To: linux-kernel@vger.kernel.org
Subject: a question: handling tasks
Mime-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to develop an application through traditional c 
language, which is gonna run as a  single instance within the system. 
Been looking on the internet for singleton (which seems to stand for OO 
programming languages, single instance appl, etc.), and also seen 
howtos and papers talking about user and kernel modes.

Maybe the right 
solution would be to use sempahores and threads, but I get confused 
because almost all the doc on this is written for solaris which hasn't 
got the same API as pthreads.

The thing is that, in case of the user 
trying to execute another instance of the appl. the already running one 
could catch the first argument used to call the second instance and 
pass it through a function.

I know this is not the right place for 
asking this, been looking for weeks, and I haven't found any document 
on the internet on how to do somehting like this with linux, and for 
sure any of you could bring some light into this.

Kind Regards,

