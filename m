Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318270AbSIGQCR>; Sat, 7 Sep 2002 12:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318767AbSIGQCR>; Sat, 7 Sep 2002 12:02:17 -0400
Received: from packet.digeo.com ([12.110.80.53]:38793 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318270AbSIGQCR>;
	Sat, 7 Sep 2002 12:02:17 -0400
Message-ID: <3D7A2768.E5C85EB@digeo.com>
Date: Sat, 07 Sep 2002 09:20:56 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
References: <20020907121854.10290.qmail@linuxmail.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Sep 2002 16:06:51.0368 (UTC) FILETIME=[93B88680:01C25688]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> 
> Hi all,
> I've just ran lmbench2.0 on my laptop.
> Here the results (again, 2.5.33 seems to be "slow", I don't know why...)
> 

The fork/exec/mmap slowdown is the rmap overhead.  I have some stuff
which partialy improves it.

The many-small-file-create slowdown is known but its cause is not.
I need to get oprofile onto it.
