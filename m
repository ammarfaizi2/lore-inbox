Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWGITAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWGITAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWGITAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:00:09 -0400
Received: from mail.cs.umn.edu ([128.101.32.202]:19661 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S1161052AbWGITAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:00:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17585.20765.134453.441965@hound.rchland.ibm.com>
Date: Sun, 9 Jul 2006 13:55:25 -0500
To: "Avinash Ramanath" <avinashr@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Zeroing data blocks
In-Reply-To: <abcd72470607081819j30e775cdx6cc8841e43f49373@mail.gmail.com>
References: <abcd72470607081819j30e775cdx6cc8841e43f49373@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: boutcher@cs.umn.edu (Dave Boutcher)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006 18:19:13 -0700, "Avinash Ramanath" <avinashr@gmail.com> said:
> 
> I am trying to zero data blocks whenever an unlink is invoked as part
> of a secure delete filesystem.
> I tried to zero the file by writing a buffer (of file size) with
> zeroes onto the file.

Hmm...you may want to look at
https://www.redhat.com/archives/ext3-users/2006-April/msg00004.html
for a slightly cleaner approach.  I just used that patch on a 
2.6.17 and it worked fine.

Dave B
