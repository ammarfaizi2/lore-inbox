Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVEJIQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVEJIQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 04:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVEJIQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 04:16:00 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:33953 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261576AbVEJIPv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 04:15:51 -0400
Message-ID: <42806DF8.8020503@bull.net>
Date: Tue, 10 May 2005 10:16:56 +0200
From: Derbey Nadia <Nadia.Derbey@bull.net>
Organization: BULL/DT/OSwR&D/AIX
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akt-announce@lists.sourceforge.net
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Automatic Kernel Tunables
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/05/2005 10:26:20,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/05/2005 10:26:20,
	Serialize complete at 10/05/2005 10:26:20
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm pleased to announce a new project related to Linux kernel tunables.
Any comment you have will be welcome!

Automatic Kernel Tunables Project
-------------------------

The AKT (Automatic Kernel Tunables) project aims at:

1. providing a standard API to unify the various ways Linux developers 
have to access kernel tunables, system information, resource 
consumptions: today, installation scripts, supervision scripts and more 
generally applications are facing the following issues:
    . There are quite multiple ways of accessing the kernel
      configuration and tunables: /procfs, /sysfs, sysconf(),
      rlimit(), etc...,
    . The associated executables are rarely portable, since they
      require to get, set and change values that are represented
      by objects that may change from distribution to distribution,
      or from one release to the other inside the same distribution.
This raises the need for a standard, well defined API to manipulate the 
kernel configuration and tunables for software products to relay on.
This API will be built on top of the existing mechanisms: it will "hide" 
them instead of replacing them, in order not to break backward 
compatibility.

2. making the kernel able to automatically tune the resources as it sees 
appropriate. This is a much more complicated feature that will be 
considered as a second step for the project


A design about 1st point will be available soon at 
http://akt.sourceforge.net/.
Everything related to this project will be dropped at this url, and 
further discussions will take place in the dedicated project mailing 
lists at SF.

Regards,
Nadia

-- 


