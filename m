Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUBRUmd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUBRUmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:42:33 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:5784 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S266884AbUBRUma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:42:30 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Wed, 18 Feb 2004 20:42:20 -0000
MIME-Version: 1.0
Subject: 2.6.3 NFS kernel warning 
Message-ID: <4033CE2C.19615.76C399@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am not registered with the list, so please CC if possible - thanks.

I am not sure if this is a problem to report (as opposed to my old 
system's problem), but I get this now in dmesg after building 2.6.3 
tonight:

nfs_read_super: get root inode failed

This is 2.6.3 mounting a NFS from an old 486 box running Linux 2.2.13 
- and the NFS processes of the same age.

The mount still works OK though; logs from the 486 report no 
warnings/errors apart from the version 3 is unknown.

But I am intrigued why it gives this warning (and the inode.c code 
seems to imply it is a fatal error, AFAIK) if it still works?

Thanks, and regards,

Nick

-- 
"I am not Spock", said Leonard Nimoy.
"And it is highly illogical of humans to assume so."

