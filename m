Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264827AbUFGPye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbUFGPye (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUFGPya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:54:30 -0400
Received: from moutng.kundenserver.de ([212.227.126.173]:18658 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264827AbUFGPyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:54:03 -0400
To: =?iso-8859-1?Q?Jan_Dittmer?= <j.dittmer@portrix.net>
Subject: =?iso-8859-1?Q?Re:_Re:_new_icc_kernel_patch_available_(with_kernel_PGO)?=
From: <ingo@pyrillion.org>
Cc: <linux-kernel@vger.kernel.org>
Message-Id: <5685161$108662280340c48c539ad7e1.06148235@config7.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 5685161
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Mon,  7 Jun 2004 17:52:02 +0200
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.134
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I published some preliminary results in the German Linux Magazine, which
are copyrighted now. Sorry.
Some hints: maximum performance gain approx. 40%, avg. perf. gain:
approx. 8%; computed by LMBench+OProfile (accurate CPU cycle
measurement, 10us timer resolution).
These results were taken from a "general kernel", i.e. widespread kernel
load (foreground and background activities, networking, filesystems,
drivers, etc.) during kernel PGO instrumentalization.
The big advantage of kernel PGO: you can create your own specialized
kernels for dedicated tasks (3 phase compilation scheme: primary
compilation, kernel profiling (PGO), feedback compilation).

Jan Dittmer <j.dittmer@portrix.net> schrieb am 07.06.2004, 16:51:06:
> Zitat von ingo@pyrillion.org:
> > v0.9.1: please check http://www.pyrillion.org/linuxkernelpatch.html for
> > a new kernel patch including kernel PGO (profile guided optimization)
> > support, covers 2.6.3 - 2.6.6 (please note: 2.6.3, 2.6.4 deprecated).
> 
> Do you have any benchmark numbers that show any improvement?
> 
> Jan
> 
> --
> j.dittmer@portrix.net
