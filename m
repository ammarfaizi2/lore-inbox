Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130811AbQKANk2>; Wed, 1 Nov 2000 08:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130762AbQKANkT>; Wed, 1 Nov 2000 08:40:19 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:58386 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130809AbQKANjs>; Wed, 1 Nov 2000 08:39:48 -0500
Date: Wed, 1 Nov 2000 09:41:04 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Yann Dirson <ydirson@altern.org>
cc: linux-kernel@vger.kernel.org, riel@nl.linux.org, andrea@e-mind.com
Subject: Re: Looking for better 2.2-based VM (do_try_to_free_pages fails,
 machine hangs)
In-Reply-To: <20001101133307.A10265@bylbo.nowhere.earth>
Message-ID: <Pine.LNX.4.21.0011010940450.2774-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Nov 2000, Yann Dirson wrote:

> Hi,
> 
> Using a 2.2.17 kernel I often experience problems where I get messages like
> "VM: do_try_to_free_pages failed for <some process>", and the machine hangs
> until the VM can recover, which sometimes takes too long for me to wait.  I
> suppose that the problem is similar sometimes when I get a frozen system
> under X, but can't see the kernel messages then.
> 
> Yesterday I could reproduce this at will, with a "make -j50" on 2.2.17
> sources (as unpriviledged user).  In less than half an our syslogd stopped
> to log anything (at 00:38), and this morning I could only see those messages
> trying to free pages for (or from ?) wwwoffled.  Last load see by "top" on
> another VC was ~74.
> 
> Have some work been done for 2.2.18 that could help me ?  Are there some
> 2.2-based VM patches that could help (I found the VM-global patch from
> Andrea but have no info about what it is

VM-global It should fix your problem. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
