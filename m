Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUFPPTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUFPPTw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 11:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUFPPTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 11:19:52 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:4763 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S263100AbUFPPTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 11:19:51 -0400
Message-ID: <40D0659E.5040900@ru.mvista.com>
Date: Wed, 16 Jun 2004 19:22:06 +0400
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel sema implementation question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Community!

Could anybody please answer the question about kernel semaphore up() 
routine. I use kernel 2.6.6 on i386 but the question is about arch 
independent part.

Arch dependent up() implementation leads to try_to_wake_up () which 
calls resched_task() if the task been woken up  preempts the current task.

The question is - when the context switch  actually occures?
(resched_task only sets the bit but doesn't switch anything)

Thanks,
		Eugeny

