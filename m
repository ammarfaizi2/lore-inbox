Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbUAAVQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 16:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUAAVOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:14:17 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:44284 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S265080AbUAAU71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:59:27 -0500
Date: Fri, 02 Jan 2004 09:57:36 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Dri-devel] 2.6 kernel change in nopage
In-reply-to: <Pine.LNX.4.58.0401011205110.2065@home.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
       Arjan van de Ven <arjanv@redhat.com>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Message-id: <1072990656.25583.18.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20031231182148.26486.qmail@web14918.mail.yahoo.com>
 <1072958618.1603.236.camel@thor.asgaard.local>
 <1072959055.5717.1.camel@laptop.fenrus.com>
 <1072959820.1600.252.camel@thor.asgaard.local>
 <20040101122851.GA13671@devserv.devel.redhat.com>
 <1072967278.1603.270.camel@thor.asgaard.local>
 <Pine.LNX.4.58.0401011205110.2065@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-02 at 09:19, Linus Torvalds wrote:
> In contrast, full-file interfaces for different kernel versions are a 
> _lot_ easier to merge and keep track of. They may look like "duplication", 
> but the advantages are legion. You don't mix different OS's and different 
> versions together, and that makes it much easier to support them all 
> without going crazy.

Of course there are also advantages to _not_ using the file-per-kernel
version scheme. Keeping one set of files means time is not wasted
applying the same change to multiple variations, removes the possibility
of patches getting applied to one version and not another and simplifies
the process of continuing to support old kernel versions. For merging, a
bit of test processing on the files could always be used to remove the
ugliness and clean things up.

Regards,

Nigel
-- 
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

