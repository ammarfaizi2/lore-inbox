Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130108AbQJ0LDi>; Fri, 27 Oct 2000 07:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130146AbQJ0LD2>; Fri, 27 Oct 2000 07:03:28 -0400
Received: from mailhost.digitalselect.net ([209.136.236.13]:58381 "EHLO
	mailhost.digitalselect.net") by vger.kernel.org with ESMTP
	id <S130108AbQJ0LDM>; Fri, 27 Oct 2000 07:03:12 -0400
Date: Fri, 27 Oct 2000 07:03:29 -0400
From: James Lewis Nance <jlnance@intrex.net>
To: linux-kernel@vger.kernel.org
Subject: New VM problem
Message-ID: <20001027070329.A884@bessie.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
    I am running a 2.4.0-test9 kernel and I have noticed a VM problem I
have not seen reported before.  The machine is a uniprocessor Pentium
II with 2G of ram, and the kernel is compiled with CONFIG_HIGHMEM4G and
CONFIG_HIGHMEM both set to y.  I also have 512M of swap on the machine.
    I left a single large job running when I left yesterday afternoon
(size=1651M, RSS=1.5G).  When I got in this morning I wanted to see if
it was still running so I typed "top" in an Xterm.  When I hit return I
thought the machine had crashed.  I could not move the cursor with the
mouse, or cause any other activity.  I went and got a cup of coffe and
when I came back the machine was alive again.  I then started netscape and
the machine appeared to crash again.  It was completly unresponsive for
about 30 seconds and then it came back to life.  As I type this message
into netscape, the machine will periodically freeze for about 30 seconds
and then come back to life.  Anybody have any idea of whats going on?
    On an unrelated note, is it possible for a process in 2.4 to see more
than 2G of address space?  They seem to be limited to 2G for me.  I was
hoping that the HIMEM stuff had removed that limit.

Thanks,

Jim
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
