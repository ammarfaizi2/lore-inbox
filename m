Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751897AbWCEW6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbWCEW6h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWCEW6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:58:37 -0500
Received: from smtp04.ya.com ([62.151.11.162]:59790 "EHLO smtpauth.ya.com")
	by vger.kernel.org with ESMTP id S1751901AbWCEW6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:58:35 -0500
Message-ID: <440B6D11.9040301@ya.com>
Date: Sun, 05 Mar 2006 23:58:25 +0100
From: =?ISO-8859-1?Q?Ra=FAl_Baena?= <raul_baena@ya.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: es-es, es
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Doubt about scheduler
References: <4407584A.60301@ya.com> <35fb2e590603032233i7302162do553ba61674cc8e50@mail.gmail.com> <440AE3F3.3090404@ya.com> <440AE7E3.4060500@yahoo.com.au> <440B681C.8030403@bigpond.net.au>
In-Reply-To: <440B681C.8030403@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams escribió:

> SuSE patched their 2.6.5 kernel to make the run queues visible in a 
> header file.  Perhaps Raul was using a SuSE version of 2.6.5.

Exact!!!! . To be honest, I have the 2.6.12 version to debian, but my 
project tutor has this one. And when I argued about my project and I 
told him that those fields weren´t accesible, he sent me his sched.h, 
and I saw that runqueue and prio_array were accesible in it. I didn´t 
think that it was a SUSE patch . Sorry, it's my fault

I have made a litte cheat to be able to see prio_array fields, I have 
created a new struct and later with the "array" field of "task_struct" I 
have made a cast to my struct. Then I have been able to show these 
values, but I don't like this "solution", because I can´t know anything 
of tasks in another state ("active" or "expired"), neither which is my 
state!! For this reason I would like to know how to get this 
information, my project have to be done in June 30 :(.

Thank you very much again for your help, I´m getting a lot of 
information about the kernel that I'll be able to use in my report, of 
course if you agree.


