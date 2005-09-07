Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVIGLyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVIGLyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVIGLyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:54:04 -0400
Received: from mail1.bizmail.net.au ([202.162.77.164]:12167 "EHLO
	mail1.bizmail.net.au") by vger.kernel.org with ESMTP
	id S1751187AbVIGLyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:54:03 -0400
Message-ID: <431ED4C1.6020406@bizmail.com.au>
Date: Wed, 07 Sep 2005 21:53:37 +1000
From: YH <yh@bizmail.com.au>
Reply-To: yh@bizmail.com.au
Organization: yh@bizmail.com.au, yhus@suers.sf.net, yudeh@rtunet.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: system IPC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the kernel disallows drivers to use system IPC. 
Asynchronous communication mechanism is very effective mechanism among 
various embedded OSes, even popular in RTOSes. Any reason why cannot use 
sys_msgsnd and sys_msgrcv for kernel drivers?

