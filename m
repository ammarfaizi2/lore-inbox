Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSHXQ71>; Sat, 24 Aug 2002 12:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSHXQ71>; Sat, 24 Aug 2002 12:59:27 -0400
Received: from [213.4.129.129] ([213.4.129.129]:29410 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id <S316544AbSHXQ70>;
	Sat, 24 Aug 2002 12:59:26 -0400
Date: Sat, 24 Aug 2002 19:02:50 +0200
From: Arador <diegocg@teleline.es>
To: Robert Love <rml@tech9.net>
Cc: thunder@lightweight.ods.org, dag@newtech.fi, linux-kernel@vger.kernel.org,
       conman@kolivas.net
Subject: Re: Preempt note in the logs
Message-Id: <20020824190250.796126ac.diegocg@teleline.es>
In-Reply-To: <1030205733.857.4892.camel@phantasy>
References: <Pine.LNX.4.44.0208240344470.3234-100000@hawkeye.luckynet.adm>
	<1030205733.857.4892.camel@phantasy>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Aug 2002 12:15:32 -0400
Robert Love <rml@tech9.net> escribió:
> No, that is not just preempt being unclean.
> 
> Dan, you have a problem.  Something in your kernel is doing stupid
> things with locks and most of your tasks are not even preemptible.

I can see all those messages, too. A lot of tasks (if not all)
seems to exit with a "note: task[PID] exited with preempt_count 1"

The kernel I'm using is 2.4.19-ck2-rmap from Con Colivas
wich can be found at http://kernel.kolivas.net

It's a plain 2.4.29 + 
sched-2.4.19-rc2-A4
preempt-kernel-rml-2.4.19-rc5-3.patch
2.4.19-low-latency.patch
2.4.19-rmap14a or 2.4.19-rc5aa1 05_vm_* (rmap in my case)
 
> Do you use XFS?  If not, what fs?

Reiserfs

Diego Calleja
