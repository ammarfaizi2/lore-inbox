Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268096AbTB1TEB>; Fri, 28 Feb 2003 14:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268098AbTB1TEB>; Fri, 28 Feb 2003 14:04:01 -0500
Received: from packet.digeo.com ([12.110.80.53]:19620 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268096AbTB1TEA>;
	Fri, 28 Feb 2003 14:04:00 -0500
Date: Fri, 28 Feb 2003 11:14:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: anticipatory scheduling questions
Message-Id: <20030228111418.40eefd3b.akpm@digeo.com>
In-Reply-To: <20030228143811.9488.qmail@linuxmail.org>
References: <20030228143811.9488.qmail@linuxmail.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 19:14:15.0462 (UTC) FILETIME=[95999C60:01C2DF5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote:
>
> Maybe I did not express myself correctly in my previous message: there are no such 
> delays. Since the moment I click Reply for the very first time until the window opens up, 
> there is no disk idle time. 
>  
> > I'd suggest that you launch evolution from the command line in an xterm so 
> > you can watch for any diagnostic messages. 
>  
> I have done so: Evolution is a complex application with many interdependencies and is 
> not very prone to launch diagnostic messages to the console. Anyways, I haven't seen 
> any diagnostic message in the console. I still think there is something in the AS I/O scheduler 
> that is not working at full read throughput. Of course I'm no expert. 

It certainly does appear that way.  But you observed the same runtime
with the deadline scheduler.  Or was that a typo?

> > 2.4.20-2.54 -> 9s  
> > 2.5.63-mm1 w/Deadline -> 34s  
> > 2.5.63-mm1 w/AS -> 33s 

