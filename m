Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUAQCRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 21:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUAQCRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 21:17:32 -0500
Received: from hera.cwi.nl ([192.16.191.8]:34964 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265993AbUAQCRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 21:17:31 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 17 Jan 2004 03:17:23 +0100 (MET)
Message-Id: <UTC200401170217.i0H2HNt16225.aeb@smtp.cwi.nl>
To: akpm@osdl.org
Subject: CLONE_DETACHED
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My current version of the clone.2 manual page says

       CLONE_THREAD
              (Linux 2.4 onwards) If  CLONE_THREAD  is  set,  the
              child  is  placed  in  the same thread group as the
              calling process.  Now in 2.6 also  the  meaningless
              CLONE_DETACHED  (introduced in 2.5.32) must be set.

I wonder whether it is too late to remove CLONE_DETACHED entirely.
There are precisely two occurrences: the definition and the check
that it is set when CLONE_THREAD is set. Seems fairly useless.

Andries
