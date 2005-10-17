Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVJQIEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVJQIEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 04:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVJQIEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 04:04:10 -0400
Received: from [210.76.114.20] ([210.76.114.20]:45963 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932125AbVJQIEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 04:04:09 -0400
Message-ID: <43535B35.5020603@ccoss.com.cn>
Date: Mon, 17 Oct 2005 16:05:09 +0800
From: liyu <liyu@ccoss.com.cn>
Reply-To: liyu@ccoss.com.cn
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Question] one question about 'current' in scheduler_tick() 
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All.

    I found scheduler_tick() use current macro to get task_struct of 
current task.
   
    I seen scheduler_tick() is called every timer interrupt at most 
time. In this
case, I think scheduler_tick() is in interrupt context (enter kernel by 
interrupt),
So I have a hunch that there have not thread_info which it need in 
kernel stack. But
It seem it can work perfectly.
 
    I can not understand this. Would any expert like explain clearly for 
it ?

    Thanks in advanced.

-liyu



   
