Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267990AbUG2PGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267990AbUG2PGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267947AbUG2PC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:02:58 -0400
Received: from jade.spiritone.com ([216.99.193.136]:22461 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S264526AbUG2OMs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:12:48 -0400
Date: Thu, 29 Jul 2004 07:12:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, fastboot@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jbarnes@engr.sgi.com
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-ID: <137530000.1091110348@[10.10.2.4]>
In-Reply-To: <m18yd362sf.fsf@ebiederm.dsl.xmission.com>
References: <16734.1090513167@ocs3.ocs.com.au><20040725235705.57b804cc.akpm@osdl.org><m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com><200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay><m14qnr7u7b.fsf@ebiederm.dsl.xmission.com><20040728133337.06eb0fca.akpm@osdl.org><1091044742.31698.3.camel@localhost.localdomain><m1llh367s4.fsf@ebiederm.dsl.xmission.com><1091055311.31923.3.camel@localhost.localdomain> <m18yd362sf.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At that point you might get a corrupt DUMP. But it is extremely
> unlikely any DMA transactions will touch your reserved memory.
> Only the most buggy drivers or hardware will be running
> DMA to the invalid addresses.  At which point there is
> very little you can do in any event.

Nothing we do is ever going to give us 100% perfect crashdumps from any
given situation. I think we need to just accept that and take care not
to destroy anything important (ie disk data), and try to get the best
info into the dump we can.

M

