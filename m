Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUJIVME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUJIVME (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 17:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUJIVMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 17:12:03 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:55486 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267438AbUJIVLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 17:11:09 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <20041008202247.GA9653@kroah.com> <528yagn63x.fsf@topspin.com>
	<41673772.9010402@pobox.com> <52zn2wlh8h.fsf@topspin.com>
	<416767BA.1020204@pobox.com>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 09 Oct 2004 14:11:06 -0700
In-Reply-To: <416767BA.1020204@pobox.com> (Jeff Garzik's message of "Sat, 09
 Oct 2004 00:23:22 -0400")
Message-ID: <52k6tzlhqt.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [openib-general] InfiniBand incompatible with the Linux kernel?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 09 Oct 2004 21:11:06.0959 (UTC) FILETIME=[7E15E5F0:01C4AE44]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> If there is questionable code, that is _not_ a justification
    Jeff> to add more.

I guess my point was not that the bluetooth stack is somehow
questionable, but rather that the IP policies of a standards bodies
are really not a good reason to keep code out of the kernel.  If
someone can name one patent that the IB driver stack looks like it
might possibly run into, then we would have to take that very
seriously.  However, no one has done this here -- all we have is FUD
or guilt by association or whatever you want to call it.

The mere fact that the IBTA bylaws only require members license their
patents under RAND terms shouldn't be an issue.  If nothing else, the
fact that there are hugely more non-IBTA member companies than member
companies who might have patents makes the IBTA bylaws almost a moot
point.

For what its worth, I know of at least five companies shipping IB
stacks and the only patent licensing that I know of is the Microsoft
SDP license, and even that is really just CYA: all Microsoft says is
that they _might_ have patents that cover SDP and that they will
license them at no cost to anyone who wants them; unfortunately this
license is not GPL-compatible, but for proprietary stacks the
zero-cost terms look fine.  There are people who have looked at
Microsoft's patents and concluded that none of them actually apply to
SDP as specified by the IBTA.

Thanks,
  Roland
