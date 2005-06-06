Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVFFBBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVFFBBe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 21:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVFFBBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 21:01:34 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:21978 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261153AbVFFBBc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 21:01:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bYthF5GCRKJV141RQsFG1IZyoyXUSfkiuPZj+OM29/5hJ8kjS9bpRgGBiMGHOSTkimsfuD57sJxsr29i/J/tFize7Bdpxp1m6XaqaPUCIkaGlqWUAtfSTw6FjcViyKlx+rK7gxfmKXpF4jpd8ZjMXnJZ1e7xWWrJFVUr5NhA/gY=
Message-ID: <4745278c050605180115a70b8d@mail.gmail.com>
Date: Sun, 5 Jun 2005 21:01:19 -0400
From: Vishal Patil <vishpat@gmail.com>
Reply-To: Vishal Patil <vishpat@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Memory problems in schedule()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am trying to implement a different process scheduling algorithm in linux
kernel 2.4.30. I am doing this as a hobby and am using User Mode Linux
to test my changes. I have the following problems with the implement

1) Whenever I select a process to run using my algorithm the kernel
panics with "Segfault with no mm" basically the "mm" field of the
task_struct that I selected is empty. I don't understand why this
should happen, since I have just added code to select a process and
haven't modified any memory related code in the schedule() function.

2) I am able to run the UMLfied kernel under gdb, however the execution
never halts even though I set several breakpoints. Also these
breakpoints have not been set in interrupt handling code and I have
compiled the code with -g option.

I have been stuck with these problems since a long time and would
appreciate if someone could help me with it.

Thank you all.

- Vishal 

-- 
A dream is just a dream. A goal is a dream with a plan and a deadline.
