Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUKVNzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUKVNzK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 08:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbUKVNzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 08:55:10 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:51944 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262104AbUKVNyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 08:54:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Gd4YfV2j248WmddDVxBh70VHXROJbfHGp9Sxg2BPUMvLY/al9L/q3k24fW925Z9wvd72FFqIuwW+iG903eCgMFSOwwnfO7dl/Yz0jkrhg3abpFo/aU+/1F8UQ4Cg+ePsM+9V2g6w3zasw44Lka1uibs7arQ/e+lSWuqVTwi6vD4=
Message-ID: <2c59f00304112205546349e88e@mail.gmail.com>
Date: Mon, 22 Nov 2004 19:24:36 +0530
From: Amit Gud <amitgud1@gmail.com>
Reply-To: Amit Gud <amitgud1@gmail.com>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: file as a directory
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

 A straight forward question. Wouldn't adding a "file as a directory"
mechanism more logical in VFS itself, rather than having each fs (like
reiser4) to implement it seperately? My vision is to give archive-file
(.tar, .tar.gz, ...) support in the VFS itself, and of course
transparent to any fs and any user-land application. There are many
archive FSs around, but how feasible would it be to implement the
archive file support in the VFS at dentry-level? I'd be happy to share
my proposal.

AG
--
May the source be with you.
