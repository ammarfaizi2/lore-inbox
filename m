Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVBTXJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVBTXJz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 18:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVBTXJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 18:09:55 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:9576 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262102AbVBTXJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 18:09:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=j/ByGkqsP2sNjMYPjhlr/9BmUADAhQ2247X5UmgcocJgB/nx1U3+PAGTitlU8SqTvlxL+deYMbnF49IfqaeiyIjBvhPIW3i4mqAn5Dkifl9Fs/7EWIaXZy+Yq4yV0PZCbqkP6G7WtIacq2zKgu34IJITgXUvc1+a1mDEllranFM=
Message-ID: <b6d0f5fb05022015093344fa1@mail.gmail.com>
Date: Sun, 20 Feb 2005 23:09:53 +0000
From: Cameron Harris <thecwin@gmail.com>
Reply-To: Cameron Harris <thecwin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: cifs connection loss hangs
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Being a wireless user i experience the occasional connection loss due
to walking out of range or something, recently after starting to use
cifs mounts instead of smbfs, I've noticed that stuff tends to break
if i lose connection.
I first noticed this when my bootscript brought down the wireless
before it umounted the cifs share, and it hung the shutdown. Recently
i was copying some files over with a nautilus window open. I lost
connection and the nautilus window & the cp process froze. ps said
that they were stuck in D (Uninterruptible Sleep). I read it's a
kernel problem if something gets stuck in it. umounting the cifs
filesystem didn't even wake up the process, I had to reboot (which
didn't work right because something was stuck with a file open).
Anyone got any ideas on how this could be fixed? 
Thanks
-- 
Cameron Harris
