Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264804AbRFXWAX>; Sun, 24 Jun 2001 18:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264801AbRFXV6z>; Sun, 24 Jun 2001 17:58:55 -0400
Received: from jalon.able.es ([212.97.163.2]:38538 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264803AbRFXV6k>;
	Sun, 24 Jun 2001 17:58:40 -0400
Date: Thu, 21 Jun 2001 01:10:31 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Stephen Satchell <satch@fluent-access.com>
Cc: Martin Devera <devik@cdi.cz>, bert hubert <ahu@ds9a.nl>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: Threads are processes that share more
Message-ID: <20010621011031.B19922@werewolf.able.es>
In-Reply-To: <20010620175937.A8159@home.ds9a.nl> <Pine.LNX.4.10.10106202036470.10363-100000@luxik.cdi.cz> <4.3.2.7.2.20010620150729.00b60710@mail.fluent-access.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <4.3.2.7.2.20010620150729.00b60710@mail.fluent-access.com>; from satch@fluent-access.com on Thu, Jun 21, 2001 at 00:08:52 +0200
X-Mailer: Balsa 1.1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010621 Stephen Satchell wrote:
>
>By the way, I'm surprised no one has mentioned that a synonym for "thread" 
>is "lightweight process".
>

In linux. Perhaps this the fault.
In IRIX, you have sprocs and threads. sprocs have independent pids and you
can control what you share (mappings, fd table...). Threads group under
same pid.
Linux chose the sproc way...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac15 #2 SMP Sun Jun 17 02:12:45 CEST 2001 i686
