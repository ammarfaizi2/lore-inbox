Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbTKIOm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 09:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTKIOm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 09:42:28 -0500
Received: from sphere.barak.net.il ([212.150.48.98]:22928 "EHLO
	sphere.barak.net.il") by vger.kernel.org with ESMTP id S262461AbTKIOm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 09:42:28 -0500
From: "Amir Hermelin" <amir@montilio.com>
To: <linux-kernel@vger.kernel.org>
Subject: 'flushing' printk to klogd
Date: Sun, 9 Nov 2003 16:42:20 +0200
Organization: Montilio
Message-ID: <001e01c3a6cf$b13a3990$0a01a8c0@CARTMAN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Is there any way to make sure klogd flushes printk output to
/var/log/messages before the circular buffer wraps?  I intend to use this
only during the development phase, but I find that during 'activity storms'
where lots of printk's are involved I lose some of the output.

Thanks,
Amir.


