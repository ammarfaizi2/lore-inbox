Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317007AbSGLUhg>; Fri, 12 Jul 2002 16:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317959AbSGLUhe>; Fri, 12 Jul 2002 16:37:34 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:42734 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317007AbSGLUhB>;
	Fri, 12 Jul 2002 16:37:01 -0400
Date: Fri, 12 Jul 2002 13:39:49 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200207122039.g6CKdnV3004060@napali.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: MAP_NORESERVE with MAP_SHARED
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a good reason why the MAP_NORESERVE flag is ignored when
MAP_SHARED is specified?  (Hint: it's the call to vm_enough_memory()
in shmem_file_setup() that's causing MAP_NORESERVE to be ignored.)

	--david
--
Interested in learning more about IA-64 Linux?  Try http://www.lia64.org/book/
