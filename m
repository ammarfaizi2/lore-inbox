Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbSKMAeU>; Tue, 12 Nov 2002 19:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267064AbSKMAeU>; Tue, 12 Nov 2002 19:34:20 -0500
Received: from mail.gurulabs.com ([208.177.141.7]:61586 "EHLO
	mail.gurulabs.com") by vger.kernel.org with ESMTP
	id <S267032AbSKMAeU>; Tue, 12 Nov 2002 19:34:20 -0500
Subject: courier-imap/maildrop now doing proper fsync'ing
From: Dax Kelson <dax@gurulabs.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 17:44:01 -0700
Message-Id: <1037148241.25372.14.camel@aramis>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The newest versions of courier-imap, a maildir POP3/POP3S/IMAP/IMAPS
server, and maildrop, a MDA, now have a compile time configure option:

--with-dirsync

Should it now be safe to run ext3 filesystems (that contain the
maildirs) with data=writeback?

BTW, procmail isn't doing proper fsyncing when writing to a maildir.

Dax

