Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131788AbRCORmR>; Thu, 15 Mar 2001 12:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131784AbRCORmI>; Thu, 15 Mar 2001 12:42:08 -0500
Received: from smtp.primusdsl.net ([209.225.164.93]:56583 "EHLO
	mailhost.digitalselect.net") by vger.kernel.org with ESMTP
	id <S131772AbRCORmE>; Thu, 15 Mar 2001 12:42:04 -0500
Date: Thu, 15 Mar 2001 12:43:16 -0500
From: James Lewis Nance <jlnance@intrex.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Is swap == 2 * RAM a permanent thing?
Message-ID: <20010315124316.A29421@bessie.dyndns.org>
In-Reply-To: <20010315170910.C4921@pc8.inup.com> <Pine.LNX.4.33.0103152025340.1320-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103152025340.1320-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Mar 15, 2001 at 08:26:35PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2001 at 08:26:35PM -0300, Rik van Riel wrote:
> When we swap something in from swap, it is in effect "duplicated"
> in memory and swap. Freeing the swap space of these duplicates
> will mean we have, effectively, more swap space.

Hi Rik,
    Thanks for the explanation.  It brings another question to mind.  Lets
assume that I have two 16M processes and 32M of swap space.  Both the
processes have been swapped out at some point in time so the swap space is
full.  A third process is running and tries to allocate some memory, and
the kernel has no free pages.  Since swap is full, will the kernel kill my
process, or will it try and page out one of the processes that does have
space on swap?

Thanks,

Jim
