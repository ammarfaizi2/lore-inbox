Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQKISA3>; Thu, 9 Nov 2000 13:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129619AbQKISAM>; Thu, 9 Nov 2000 13:00:12 -0500
Received: from mail-04-real.cdsnet.net ([63.163.68.109]:62220 "HELO
	mail-04-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129595AbQKIR77>; Thu, 9 Nov 2000 12:59:59 -0500
Message-ID: <3A0AE6E4.103C13F5@mvista.com>
Date: Thu, 09 Nov 2000 10:03:16 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Swiedler <chris.swiedler@sevista.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: getting a process name from task struct
In-Reply-To: <NDBBIAJKLMMHOGKNMGFNCEEHCPAA.chris.swiedler@sevista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Swiedler wrote:
> 
> Is it possible to get a process's name / full execution path (from
> kernelspace) given only a task struct? I can't find any pointers to this
> information in the task struct, and I don't know where else it might be. ps
> seems to be able to get the process name, but that's from userspace.
> Apologies in advance if this is a stupid question.
> 
> chris
> 
Try the "comm" member of task_struct.  (Clear name, right?)

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
