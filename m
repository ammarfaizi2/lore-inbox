Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752142AbWCNDhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbWCNDhg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 22:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbWCNDhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 22:37:36 -0500
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:50060 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932536AbWCNDhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 22:37:35 -0500
Message-ID: <BAYC1-PASMTP03885459DFC95D073D483EAEE10@CEZ.ICE>
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Mon, 13 Mar 2006 22:35:20 -0500
From: sean <seanlkml@sympatico.ca>
To: jonathan@jonmasters.org
Cc: jonmasters@gmail.com, anshu.pg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
Message-Id: <20060313223520.113bc6d0.seanlkml@sympatico.ca>
In-Reply-To: <35fb2e590603131902i66afe836y6653a20405bc5818@mail.gmail.com>
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
	<20060308102731.GO27946@ftp.linux.org.uk>
	<ec92bc30603080252v7e795b4dm5116d4fe78f92cc7@mail.gmail.com>
	<1141815315.10151.0.camel@laptopd505.fenrus.org>
	<ec92bc30603080302j8c4b6a6se38fdeda05b8fe45@mail.gmail.com>
	<35fb2e590603131902i66afe836y6653a20405bc5818@mail.gmail.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2006 03:37:34.0692 (UTC) FILETIME=[A1DB2A40:01C64718]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006 03:02:12 +0000
"Jon Masters" <jonmasters@gmail.com> wrote:

> It strikes me that this thread isn't really about binary-only drivers
> and that whole ugly discussion. What it's really about is getting
> third party drivers to work with Linux more easily. That conversation
> does involve the "out of tree vs. upstream" question, but mention of
> binary-only drivers actually only serves to cloud the real issue here.

But that debate has been settled.   The only possible solution to making 
3rd party drivers easier to use is to make a stable driver-ABI.  And the
reason that isn't going to happen has been explained many times already.

Linux is designed around having all drivers in the source tree, which 
removes the problems experienced by out-of-tree drivers.  The pain felt
by those promoting and using 3rd party drivers is brought on _themselves_
by being unable or unwilling to adapt to the Linux environment.

Demanding that Linux adapt to the needs of 3rd party drivers ignores 
the fact that this will just shift the pain onto the core kernel
developers.   That pain would ultimately be felt by all Linux users 
who would then get a kernel which is artifically constrained by all 
these old interfaces.  It would destroy one of the key advantages open
source offerings have over the closed source.   In other words, it
would do more harm than good.

In the end, most of the demands for Linux to "adapt" come from people 
who really don't appreciate or embrace open source.   I think kernel
developers are protecting Linux (and thus its users) by ignoring these
often vitriolic demands for it to conform to the way things are done
in the closed source world.

Cheers,
Sean
