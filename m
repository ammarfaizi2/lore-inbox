Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTEJRNb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 13:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTEJRNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 13:13:30 -0400
Received: from 12-249-212-150.client.attbi.com ([12.249.212.150]:57251 "EHLO
	rekl.yi.org") by vger.kernel.org with ESMTP id S264450AbTEJRNa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 13:13:30 -0400
Date: Sat, 10 May 2003 12:26:05 -0500 (CDT)
From: Rob Ekl <lkhelp@rekl.yi.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled *RESOLVED*
In-Reply-To: <Pine.LNX.4.53.0305101146550.1714@rekl.yi.org>
Message-ID: <Pine.LNX.4.53.0305101222380.1773@rekl.yi.org>
References: <Pine.LNX.4.53.0305092018530.16627@rekl.yi.org>
 <Pine.LNX.4.53.0305101146550.1714@rekl.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After looking at the bits in the "drive features supported" and comparing 
> against the spec, neither drive supports TCQ.  The test-tcq.pl script with 
> the correct bit-shift operators also shows that neither drive supports 
> TCQ.


For future reference, hdparm also displays if the drive supports command
queuing, since version 4.2.  If supported, it will show "Cmd queuing"
under "Capabilities".

