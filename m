Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUCIRXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 12:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbUCIRXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 12:23:41 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:43182 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262064AbUCIRXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 12:23:37 -0500
Date: Tue, 09 Mar 2004 09:23:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>
cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <1451890000.1078853007@[10.10.2.4]>
In-Reply-To: <20040309163345.GK8193@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <1078781318.4678.9.camel@laptop.fenrus.com> <20040308230845.GD12612@dualathlon.random> <20040309074747.GA8021@elte.hu> <20040309152121.GD8193@dualathlon.random> <20040309153620.GA9012@elte.hu> <20040309163345.GK8193@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> what is your point, that OASB is a worthless workload and the only thing
> that matters is TPC-C? Maybe you should discuss your point with Oracle
> not with me, since I don't know what the two benchmarks are doing
> differently. TCP-C was tested too of course, but maybe not in 32G boxes,
> frankly I thought OASB was harder than TCP-C, as I think Martin
> mentioned too two days ago.

OASB seems harder on the VM than TPC-C, yes. It seems to create thousands
of processes, and fill the user address space up completely as well (2GB
shared segments or whatever).

M.

