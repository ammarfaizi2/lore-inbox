Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266568AbUHXGuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266568AbUHXGuR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUHXGuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:50:17 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:17051 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S266568AbUHXGuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:50:13 -0400
Message-ID: <412AE521.5030608@bull.net>
Date: Tue, 24 Aug 2004 08:50:09 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ELSA v0.1 for 2.6.8.1
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/08/2004 08:55:23,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/08/2004 08:55:26,
	Serialize complete at 24/08/2004 08:55:26
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

    Enhanced Linux System Accounting is now available for kernel 2.6.8.1. This patch implements a solution for managing a group of process (called a bank) in order to provide accounting values like memory, I/O or CPU usage. Process can be added to or removed from a bank using the "elsacct" device interface with ioctl. There is no major improvements since the "bank" mechanism is working well.  

    The next step is to provide more accounting metrics. Therefore we are working on the improvement of BSD accounting as ELSA accounting is based on it. We currently trying to get informations about I/O as fields are already present in BSD-like accounting but they are not updated.

    You can download the patch from the elsa website at:
http://prdownloads.sourceforge.net/elsa/patch-2.6.8.1-elsa?download

    All project files can be found at:
http://sourceforge.net/project/showfiles.php?group_id=105806


    Any comments are welcome,
    
The ELSA team 
http://elsa.sf.net

