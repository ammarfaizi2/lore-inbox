Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbVH0H0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbVH0H0h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 03:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbVH0H0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 03:26:37 -0400
Received: from effigent.net ([210.211.230.208]:54499 "EHLO effigent.net")
	by vger.kernel.org with ESMTP id S1030333AbVH0H0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 03:26:37 -0400
Message-ID: <43101357.7060103@effigent.net>
Date: Sat, 27 Aug 2005 12:46:39 +0530
From: raja <vnagaraju@effigent.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: pid
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I am trying to find the pid of the process with out using the 
getpid() using the following program.

int main()
{
    struct thread_info * threadInfo = current_thread_info();
    struct task_struct *taskInfo = threadInfo->task;
    printf("Pid Is %d\n",taskInfo->pid);
}


And when i try to compile using
gcc  -Wall  pid.c

Then I am getting so many errors like


pid.c:9: warning: implicit declaration of function `current_thread_info'
pid.c:9: warning: initialization makes pointer from integer without a cast
pid.c:10: error: dereferencing pointer to incomplete type
pid.c:11: error: dereferencing pointer to incomplete type



Will you please help me.

