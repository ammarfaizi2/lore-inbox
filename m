Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272757AbTHEMrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272759AbTHEMrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:47:31 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:53915 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S272757AbTHEMrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:47:23 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Stephan von Krawczynski <skraw@ithnet.com>
Date: Tue, 5 Aug 2003 14:46:52 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: decoded problem in 2.4.22-pre10
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <943FB181AFA@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Aug 03 at 14:23, Stephan von Krawczynski wrote:
> 
> Hello Petr,
> 
> at this time I can't provide you with details or exact reporting as the box has
> to be used for finding the 2.4.22-pre stability problem I see. And since the
> crashes take quite some time to occur I cannot reboot and check out what's the
> deal with the vmware modules.
> And frankly: I find the application quite ok but tainting the kernel with the
> closed source modules is really something to think about, especially since
> there should be easy ways to avoid that completely.

This is not true. VMware modules are open source, they are just non-GPL.

And no, it is impossible to avoid them. At least nobody I know knows how
to avoid them.

There is only known problem (fixed in 
ftp://platan.vc.cvut.cz/pub/vmware/vmware-any-any-update38.tar.gz) that
SuSE backported epoll patches from 2.5.x to both 2.4.19 and 2.4.20, and
while this seriously changes poll_initwait semantic, it caused only
warning at compile time, but at runtime it was corrupting kernel
stack. But I do not see epoll patches in 2.4.22pre10, so it must
be something else.
                                                    Best regards,
                                                        Petr Vandrovec

