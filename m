Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310317AbSCGN3K>; Thu, 7 Mar 2002 08:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310316AbSCGN3A>; Thu, 7 Mar 2002 08:29:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9486 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310320AbSCGN2p>; Thu, 7 Mar 2002 08:28:45 -0500
Subject: Re: root-owned /proc/pid files for threaded apps?
To: duvall@emufarm.org (Danek Duvall)
Date: Thu, 7 Mar 2002 13:43:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020307060110.GA303@lorien.emufarm.org> from "Danek Duvall" at Mar 06, 2002 10:01:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iyBW-0002HP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just upgraded from 2.4.8-pre3-ac2 to 2.4.19-pre2-ac2, and found that
> for threaded programs like mozilla and xmms, files in /proc/<pid> are
> owned by root, even if the process belongs to another user.  I
> particularly wanted to be able to read /proc/<pid>/environ, but I can't.
> 
> Is this a known problem?  I haven't seen it float by.
> 
> I'll backtrack kernels to see if I can find the patch that caused it and
> report back if I hear nothing.

Thanks - that will really help. There are several sets of thread related
changes in -ac. Its all working for me however 8)
