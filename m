Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289989AbSBOQZL>; Fri, 15 Feb 2002 11:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290009AbSBOQZB>; Fri, 15 Feb 2002 11:25:01 -0500
Received: from mail-6.tiscalinet.it ([195.130.225.152]:34805 "EHLO
	mail.tiscalinet.it") by vger.kernel.org with ESMTP
	id <S289989AbSBOQYz>; Fri, 15 Feb 2002 11:24:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>
Organization: -ENOENT
To: linux-kernel@vger.kernel.org
Subject: Redundant syscalls?
Date: Fri, 15 Feb 2002 17:24:02 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02021517152700.01701@odyssey>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was wondering why do we need fsetxattr(2), fgetxattr(2) etc when we 
already have setxattr(2), getxattr(2) etc working on file names
instead of file descriptors.
truncate(2)/ftruncate(2) is another more traditional example.

Thanks
