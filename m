Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271310AbTGQB1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 21:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271313AbTGQB1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 21:27:49 -0400
Received: from fed1mtao07.cox.net ([68.6.19.124]:43229 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S271310AbTGQB1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 21:27:47 -0400
To: Pedro Ribeiro <deadheart@netcabo.pt>
cc: backblue <backblue@netcabo.pt>, linux-kernel@vger.kernel.org
Subject: Re: Not showing ac2
References: <fa.c2sgv20.1d0ea98@ifi.uio.no> <fa.hi0vnsa.8i2u8s@ifi.uio.no>
From: junkio@cox.net
Date: Wed, 16 Jul 2003 18:42:34 -0700
In-Reply-To: <fa.hi0vnsa.8i2u8s@ifi.uio.no> (backblue@netcabo.pt's message
 of "Thu, 17 Jul 2003 01:16:09 GMT")
Message-ID: <7voezund2t.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "bb" == backblue  <backblue@netcabo.pt> writes:

bb> Just check if the source was really patched, maybe the
bb> source does not patch de Makefile and did not changed the
bb> EXTRAVERSION var that is where it should be changed, maybe
bb> the -ac2 patch it's for 2.6.0-test1 original, and nor for
bb> 2.6.0-test1-ac1, that's it, just edit the Makefile, and
bb> change the EXTRAVERSION to -ac2 and recompile everything
bb> and, your are done, you have uname -a, like you want.

All of the above are sound suggestions in general, but in this
particular case of 2.6.0-test-ac2, Alan just forgot to bump the
EXTRAVERSION to -ac2 when he created the patch.

Just update EXTRAVERSION in the toplevel Makefile by hand and
rebuild, to get "uname -a" output fixed.

