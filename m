Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbTD3UTP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 16:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTD3UTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 16:19:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:65518 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261179AbTD3UTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 16:19:14 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] Linux 2.5.68 - Fix FreeXid after return in fs/cifs/inode.c
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF1BC3E8EE.7B0AFDA4-ON87256D18.0070463E@us.ibm.com>
From: Steven French <sfrench@us.ibm.com>
Date: Wed, 30 Apr 2003 15:31:05 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 6.0.1 [IBM]|April 4, 2003) at
 04/30/2003 14:31:17
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





The fix to fs/cifs/inode.c that you reference is integrated already into
the 2.5
bitkeeper tree and should be in 2.5,69 (the change was picked up as part of
five cifs vfs
changesets that were integrated last week)

>This patch applies to 2.5.68, it is listed at kbugs.org. FreeXid(xid); is
after return
>so it is never executed.
>
>Gabriel Devenyi
>
>
>- ---FILE---
>
>- --- linux-2.5.68/fs/cifs/inode.c 2003-04-19 22:48:49.000000000 -0400
>+++ linux-2.5.68-changed/fs/cifs/inode.c 2003-05-01 15:10:32.000000000
-0400
>@@ -450,10 +450,10 @@

Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com

