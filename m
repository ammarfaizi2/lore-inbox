Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbTCSAe7>; Tue, 18 Mar 2003 19:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbTCSAe7>; Tue, 18 Mar 2003 19:34:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:31914 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262868AbTCSAe6>;
	Tue, 18 Mar 2003 19:34:58 -0500
Date: Tue, 18 Mar 2003 16:39:02 -0800
From: Andrew Morton <akpm@digeo.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: torvalds@transmeta.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       coop@axian.com
Subject: Re: [PATCH] boot time parameter to turn of TSC usage
Message-Id: <20030318163902.2572ab6f.akpm@digeo.com>
In-Reply-To: <1048034299.6296.85.camel@dell_ss3.pdx.osdl.net>
References: <20030318190557.GA14447@p3.attbi.com>
	<1048019543.6294.3.camel@dell_ss3.pdx.osdl.net>
	<20030318205907.GB4081@p3.attbi.com>
	<200303182340.h2INeE4r098586@northrelay04.pok.ibm.com>
	<20030319002119.GA5351@p3.attbi.com>
	<1048034299.6296.85.camel@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 00:44:59.0881 (UTC) FILETIME=[C53B2590:01C2EDB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> wrote:
>
> For machines that don't want to cooperate and have bad TSC counter and/or
> change CPU frequency without change support.
> 
> This fixes the problem on Jerry Cooperstein's PIII laptop.
> Could be useful for other people and tech support situations.

Is there no way in which this can be auto-detected?

> +__setup("notsclock", tsc_noclock_setup);

People have recently worked to make Documentation/kernel-parameters.txt
relatively up-to-date.  Please try to remember to keep it in sync...


