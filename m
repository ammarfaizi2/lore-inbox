Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318131AbSHWBm1>; Thu, 22 Aug 2002 21:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318134AbSHWBm1>; Thu, 22 Aug 2002 21:42:27 -0400
Received: from [203.24.179.114] ([203.24.179.114]:51217 "HELO aimedics.com")
	by vger.kernel.org with SMTP id <S318131AbSHWBm1> convert rfc822-to-8bit;
	Thu, 22 Aug 2002 21:42:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: nejhdeh <nejhdeh@aimedics.com>
Organization: AiMedics Pty. Ltd.
To: linux-kernel@vger.kernel.org
Subject: Re: Basic question
Date: Fri, 23 Aug 2002 11:44:35 +1000
User-Agent: KMail/1.4.1
References: <200207190831.55757.nejhdeh@aimedics.com>
In-Reply-To: <200207190831.55757.nejhdeh@aimedics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208231144.35721.nejhdeh@aimedics.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I have a question about fork() and messages..

For simplicity, I have a parent process that forks() two child processes (say 
pid1 & pid2).

How do I set priority levels of child1 vs child2. I want child1 to have a much 
higher priority level, since its going to read inputs from a serial device in 
the outside world?

Using basic signal calls say SIGUSR1, how can I communicate (without 
semaphores) between child1 and child2 through the parent? For instance if the 
child1 gets blocked forever trying to read the serial device then I want to 
notify the parent to kill child2??

Your time in this matter is greatly appreciated.


> Regards
>
> Nejhdeh Ghevondian
