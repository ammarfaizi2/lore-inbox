Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbVKVSbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVKVSbR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVKVSbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:31:17 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:19786 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965092AbVKVSbR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:31:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IByHkvb09vAwnTMw6ba+xzJ23OAAEhgWkcWcha1PCXE3qZpkdZCkFhsB4YBD3vXj2y22xMqsxKLmhtqZoopj9DDbtdQolMp7XHR2uQeFAz8FE9VoR2Pk/EBfTxiARNQ9Rd1etsEV87ICLWvFki4P0oJxXAyTy3Ocdk8pEEy7XBE=
Message-ID: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
Date: Tue, 22 Nov 2005 13:31:16 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Christmas list for the kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There have been recent comments about the pace of kernel development
slowing. What are the major areas that still need major work? When the
thread slows down maybe Linus will tell us what the top ten items
really are.

To get things started here's a few that I would add:

1) graphics, it is a total mess.

2) get Xen merged, virtualization will be key on the server.
Hotplugable CPUs and memory are tied up in this one.

3) Reiser4 merge, Rieser4 itself is not important, it's the new
concepts about file systems that Reiser4 brings to the kernel that are
important. Get the issues around the VFS layer sorted out so that this
can happen. We need some forward evolution in file system concepts.

4) Merge klibc and fix up the driver system so that everything is
hotplugable. This means no more need to configure drivers in the
kernel, the right drivers will just load automatically.

--
Jon Smirl
jonsmirl@gmail.com
