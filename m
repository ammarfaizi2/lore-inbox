Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTLGQTy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 11:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTLGQTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 11:19:54 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:44739 "EHLO
	omta06.mta.everyone.net") by vger.kernel.org with ESMTP
	id S264449AbTLGQTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 11:19:31 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Sun, 7 Dec 2003 08:19:29 -0800 (PST)
From: Neo Wee Teck <weeteck@linux.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel include file
Reply-To: weeteck@linux.net
X-Originating-Ip: [202.156.2.210]
Message-Id: <20031207161929.7E0953951@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm... wrong idea...

<new kernel>/include/linux

update to..

/usr/include/linux

Should I?


--- Mark Hahn <hahn@physics.mcmaster.ca> wrote:
>   After upgrading to a newer version of the kernel, should I also copy/update the include folder to  /usr/include?

no!  /usr/include is userspace, which shall never use kernel headers.
the headers you find in /usr/include that *look* like kernel headers 
are in fact from glibc.



_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
