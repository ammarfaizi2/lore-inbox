Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbUDUA1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUDUA1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 20:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbUDUA1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 20:27:15 -0400
Received: from vlan400-082-019.maconline.McMaster.CA ([130.113.82.19]:60563
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S263219AbUDUA1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 20:27:11 -0400
Subject: holding a reference on an inode?
From: John McCutchan <ttb@tentacle.dhs.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082507296.3133.4.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Apr 2004 20:28:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am writing a kernel module, and I would like to allow user space to
hand me a FILE, and then for my kernel module to keep a reference on its
inode regardless what the user space program does with the FILE. 

1) Is this good practice?
2) How do I get notified when the filesystem the inode is on is being   
unmounted so I can release my reference? So that I don't block the
unmount.


I am not subscribed so please CC on my replies. 

Thank you.
