Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317297AbSFRDVv>; Mon, 17 Jun 2002 23:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317295AbSFRDVu>; Mon, 17 Jun 2002 23:21:50 -0400
Received: from mail.webmaster.com ([216.152.64.131]:2041 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317294AbSFRDVt> convert rfc822-to-8bit; Mon, 17 Jun 2002 23:21:49 -0400
From: David Schwartz <davids@webmaster.com>
To: <mgix@mgix.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Mon, 17 Jun 2002 20:21:48 -0700
In-Reply-To: <AMEKICHCJFIFEDIBLGOBCEEECBAA.mgix@mgix.com>
Subject: RE: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020618032149.AAA841@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>    This neither says nor implies anything about CPU usage. It simply says
>>that
>>the current thread will yield and be put at the end of the list.
>
>If so, please enlighten me as to when, why, and what for you would use
>sched_yield.

	Generally because you can't do something until some other thread/process 
does something, so you give it a chance to finish immediately before trying 
something a more expensive way.

>If willingly and knowingly relinquinshing a CPU does not make it possible
>for other processes to use what would otherwise have been your very own 
>slice
>of processing time then what could it be used for, I really wonder.

	It does! That's what it's for.

>Second, I have tried to run my misconception on various other OS'es I have
>access to:Win2k, Mac OSX and OpenBSD, and suprinsingly enough, all of them
>seem to be sharing my twisted views of How Things Should Be (tm).

	Just because they do what you naively expect doesn't validate your 
expectations.

	DS


