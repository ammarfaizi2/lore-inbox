Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbSL0ABe>; Thu, 26 Dec 2002 19:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbSL0ABe>; Thu, 26 Dec 2002 19:01:34 -0500
Received: from fmr02.intel.com ([192.55.52.25]:43763 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S264681AbSL0ABe>; Thu, 26 Dec 2002 19:01:34 -0500
Message-ID: <FD2423AA68A7D511A5A20002A50729E1093910B0@orsmsx115.jf.intel.com>
From: "Abbas, Mohamed" <mohamed.abbas@intel.com>
To: linux-kernel@vger.kernel.org
Subject: Question regarding clone
Date: Thu, 26 Dec 2002 16:09:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

I have some questions regarding sys_clone. I want to create a thread of the
current running process from the kernel. Looking at the source code, it is
possible to do it by calling do_fork. I just was confused about the values I
need to set pt_regs *regs parameter. Does any body know a description of how
to set it?

My second question can I create new thread of a process is not currently
running. Looking at copy_process function it only copy the process which is
currently running "it copy the current pointer"?

Thanks

Mohamed
