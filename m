Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267051AbUBMTuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 14:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267196AbUBMTuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 14:50:22 -0500
Received: from ns.suse.de ([195.135.220.2]:48575 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267051AbUBMTuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 14:50:19 -0500
Date: Fri, 13 Feb 2004 02:52:39 +0100
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: jamie@shareable.org, torvalds@osdl.org, mingo@elte.hu,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       drepper@redhat.com
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
Message-Id: <20040213025239.385dbf49.ak@suse.de>
In-Reply-To: <38670000.1076697235@flay>
References: <1076384799.893.5.camel@gaston>
	<Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
	<20040210173738.GA9894@mail.shareable.org>
	<20040213002358.1dd5c93a.ak@suse.de>
	<20040212100446.GA2862@elte.hu>
	<Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
	<20040213032604.GI25499@mail.shareable.org>
	<20040215062544.5e554a61.ak@suse.de>
	<38670000.1076697235@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 10:33:55 -0800
"Martin J. Bligh" <mbligh@aracnet.com> wrote:

> > In the standard kernel it silently overwrites, but in 2.4-aa there was a patch forever
> > that adds a guard page.
> 
> Do you happen to remember the name of the patch? Hunting in Andrea's tree
> isn't always easy ;-)

00_silent-stack-overflow-18

-Andi
