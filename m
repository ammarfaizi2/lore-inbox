Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbTDMCzy (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 22:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbTDMCzx (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 22:55:53 -0400
Received: from ms-smtp-01.tampabay.rr.com ([65.32.1.43]:64392 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S262881AbTDMCzx (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 22:55:53 -0400
Message-ID: <000701c3016a$b9d76c90$6801a8c0@epimetheus>
From: "Timothy Miller" <tmiller10@cfl.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: Quick question about hyper-threading
Date: Sat, 12 Apr 2003 23:13:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a hyper-threaded CPU, it seems to me that there could be a lot of
cache-thrashing if the two processes running are completely unrelated.  On
the other hand, if one process has two threads, then they would benefit (or
hurt less) from the cache-sharing, because they share the same memory space.
Does the HT-aware scheduler attempt to take this into account by scheduling
two related threads to run simultaneously on the same CPU as often as
possible (unless you're in a multi-processor system and another CPU would
otherwise be idle)?




