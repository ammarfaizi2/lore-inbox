Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUJIKe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUJIKe4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 06:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUJIKe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 06:34:56 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:34695 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266683AbUJIKez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 06:34:55 -0400
Message-Id: <5.1.0.14.2.20041009122437.02573718@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 09 Oct 2004 12:35:12 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: sparse and prism54
Cc: torvalds@evo.osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-ID: Eq+5ygZB8ewqoFnzzbEcsBnzmEDAdIWF1jD2WZ0cbmyLDmwheFOsgZ
X-TOI-MSGID: 8a51dabb-293a-4f2f-85b4-d70916a41559
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In cset 2004/10/05 Linus scribeth :
 > sparse still complains about the games the driver
 > plays with user pointers, though.

Yea, in isl_ioctl.c
I can get rid of all but two.
Still remains how to set xxx.data.pointer

union iwreq_data has member data.pointer which has
the __user attribute (from wireless.h)

Of course, here it is not user.

Margit 


