Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTKFJsG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 04:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTKFJsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 04:48:05 -0500
Received: from bay4-f18.bay4.hotmail.com ([65.54.171.18]:47620 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263472AbTKFJsD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 04:48:03 -0500
X-Originating-IP: [202.172.55.22]
X-Originating-Email: [slashboy84@msn.com]
From: "Wee Teck Neo" <slashboy84@msn.com>
To: linux-kernel@vger.kernel.org
Subject: Background processes
Date: Thu, 06 Nov 2003 17:48:02 +0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY4-F18UvohUuW3HSO00005dc6@hotmail.com>
X-OriginalArrivalTime: 06 Nov 2003 09:48:02.0960 (UTC) FILETIME=[12187100:01C3A44B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seems can't get this kind of background process display (ps ax)
  781 ?         S      0:00 [proftpd]
3620 ?        S      0:00 /usr/local/apache2/bin/httpd
3621 ?        S      0:00 [httpd]
3622 ?        S      0:00 [httpd]

The above is using Kernel 2.4.20-8 (Redhat 9 release)


  459 ?        S      0:00 /usr/local/apache2/bin/httpd
  460 ?        S      0:00 /usr/local/apache2/bin/httpd
  461 ?        S      0:00 /usr/local/apache2/bin/httpd
  491 pts/0    R      0:00 ps ax
  493 ?        S      0:00 proftpd: (accepting connections)


This is with kernel 2.4.22


The child process spawn is not shorten inside the square bracket

Is there any options in the kernel i need to compile in?

Nothing serious though. Just currious about the configuration ;)

_________________________________________________________________
Get 10mb of inbox space with MSN Hotmail Extra Storage 
http://join.msn.com/?pgmarket=en-sg

