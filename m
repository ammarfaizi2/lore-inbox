Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTLKVSu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 16:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTLKVSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 16:18:50 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:11685 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S262925AbTLKVSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 16:18:49 -0500
Date: Fri, 12 Dec 2003 10:07:36 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Announce: Software Suspend 2.0rc3 for 2.4 and	2.6.
In-reply-to: <20031211201444.GA18122@hell.org.pl>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1071176855.2157.1.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1071030171.3344.29.camel@laptop-linux>
 <20031211201444.GA18122@hell.org.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My fault for using Bootsplash too much :> When it's stopping on
'Freezing processes' during resume that's because as well as freezing
the processes, it's copying the original kernel back. I'll make it
display the correct message.

Regards,

Nigel

On Fri, 2003-12-12 at 09:14, Karol Kozimor wrote:
> Thus wrote Nigel Cunningham:
> > This is to announce 2.0-rc3, now being uploaded to swsusp.sf.net.
> 
> Hi,
> I've just tested it on 2.4.23 as well -- no problems found, although the
> XFS option patch needs updating -- probably as much as the 2.6 XFS code
> (though the latter seems to suspend... I'll get to it later today).
> Attached is the patch to bring the XFS code for 2.4 up to date (note: this
> is not the whole xfs-option, it should be applied on top of the latter; I
> can prepare a complete xfs-option if you care).
> 
> Oh, BTW: the slowdown I mentioned for 2.6 seems to hit this version also,
> but in a different manner: I/O is fine, but the resuming kernel spends some
> time on displaying "Freezing processes" -- what was unnoticeable under rc2
> is somewhat awkward with rc3.
> 
> Best regards,
-- 
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

