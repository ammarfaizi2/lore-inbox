Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbUCHK0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 05:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbUCHK0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 05:26:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:22988 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262401AbUCHK0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 05:26:00 -0500
Date: Mon, 8 Mar 2004 02:26:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, george@mvista.com,
       pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-Id: <20040308022602.766be828.akpm@osdl.org>
In-Reply-To: <200403081545.09916.amitkale@emsyssoft.com>
References: <200403081504.30840.amitkale@emsyssoft.com>
	<20040308015433.5424cc52.akpm@osdl.org>
	<200403081545.09916.amitkale@emsyssoft.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>
> Here are features that are present only in full kgdb:
>  1. Thread support  (aka info threads)

argh, disaster.  I discussed this with Tom a week or so ago when it looked
like this it was being chopped out and I recall being told that the
discussion was referring to something else.

Ho-hum, sorry.  Can we please put this back in?

>  2. console messages through gdb

hm, it was occasionally handy.  Is there a lot of code involved?

>  3. Automatic loading of modules in gdb

OK.  I think.  What does this feature actually do?

>  4. Support for x86_64
>  5. Support for powerpc

These are planned, I assume?

>  6. kgdb over ethernet [This isn't ready in the full version as well at this 
>  point of time]

OK.  But the version in -mm and -mpm works OK, does it not?  Is there some
difference in implementation which causes it to be broken in your tree?

