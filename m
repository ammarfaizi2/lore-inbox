Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTJNPXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 11:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbTJNPXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 11:23:13 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:31124
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262522AbTJNPXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 11:23:11 -0400
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Originally-cc: Ben Collins <bcollins@debian.org>
Subject: Re: slab corruption of hpsb_packet from ohci1394 + sbp2 on 2.6.0-test7
Message-Id: <E1A9R0v-0001Ui-00@penngrove.fdns.net>
Date: Tue, 14 Oct 2003 08:23:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending again due to broken DNS apparently causing messages to be rejected.]

Thank you very much, Ben, for a most helpful response.  Getting the 'tarball' 
from:
	http://www.linux1394.org/viewcvs/

and using its directory 'ieee1394/trunk/' in place of '.../drivers/ieee394'
indeed allows 'modprobe ohci1394' to succeed and CD/RW operations to occur.
There are still glitches, though, as 'rmmod sbp2' or 'rmmod ohci1394' give 
me backtrace(s), bug reports of which have been sent privately (and will 
be cheerfully provided upon request).  Software suspend also does not work
properly with the associated device, but i have no idea whether that ever
worked and does not appear to affect other non-CD/RW operations.

I will provide a summary of other VAIO R505EL issues with 2.6.0-test* in a
separate post after i've gotten further with debugging an 'ide-cs' problem.

Thanks again for the bug fix, as now i should be able to run a more modern
kernel to write data CDs.
				-- JM


P.S. Reading via WWW archive rather than subscribing; please reply directly
if you want something to be seen quickly.
