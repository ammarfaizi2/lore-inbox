Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269641AbRH3AUs>; Wed, 29 Aug 2001 20:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269712AbRH3AUb>; Wed, 29 Aug 2001 20:20:31 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:28425 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S269641AbRH3AUZ>;
	Wed, 29 Aug 2001 20:20:25 -0400
Date: Wed, 29 Aug 2001 18:20:40 -0600
From: Val Henson <val@nmt.edu>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org
Cc: Philipp Reisner <philipp.reisner@cubit.at>
Subject: Re: tcp connection hangs on connect
Message-ID: <20010829182040.C10934@boardwalk>
In-Reply-To: <20010828171705.F890@boardwalk> <20010829082405.A5966@cubit.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010829082405.A5966@cubit.at>; from philipp.reisner@cubit.at on Wed, Aug 29, 2001 at 08:24:05AM +0200
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kuznetsov wrote:

> Hello!
>  
> > simply hangs after some minutes to an hour. The script runs on
> > a Linux-2.2.19 Box (we have also tested Linux-2.4.2)
>  
> This bug has been fixed in later 2.4s.
>  
> Corresponding fix to 2.2 is expected to be in 2.2.20 and it is available
> in Alan's 2.2.20-pre.
> 
> Alexey

This bug still exists in 2.4.10-pre2 (from the linuxppc_2_4_devel
tree).  The first TCP connection to the machine hangs after a few KB
of data.  Connections after that work fine.  A tcpdump shows strange
retransmit behavior before the hang but I haven't investigated it
further.

Philipp Reisner says it's fixed in 2.2.20-pre8 but I can't find any
equivalent fix in 2.4.8-2.4.10.

Have I found a new bug or did the patch not make it into 2.4 after
all?

-VAL
