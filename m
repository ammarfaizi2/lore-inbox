Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUCHLHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 06:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUCHLHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 06:07:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:61668 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262451AbUCHLHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 06:07:19 -0500
Date: Mon, 8 Mar 2004 03:07:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, george@mvista.com,
       pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-Id: <20040308030722.01948c93.akpm@osdl.org>
In-Reply-To: <200403081619.16771.amitkale@emsyssoft.com>
References: <200403081504.30840.amitkale@emsyssoft.com>
	<200403081545.09916.amitkale@emsyssoft.com>
	<20040308022602.766be828.akpm@osdl.org>
	<200403081619.16771.amitkale@emsyssoft.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>
> On Monday 08 Mar 2004 3:56 pm, Andrew Morton wrote:
>  > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>  > > Here are features that are present only in full kgdb:
>  > >  1. Thread support  (aka info threads)
>  >
>  > argh, disaster.  I discussed this with Tom a week or so ago when it looked
>  > like this it was being chopped out and I recall being told that the
>  > discussion was referring to something else.
>  >
>  > Ho-hum, sorry.  Can we please put this back in?
> 
>  Err., well this is one of the particularly dirty parts of kgdb. That's why 
>  it's been kept away. It takes care of correct thread backtraces in some rare 
>  cases.

Let me just make sure we're taking about the same thing here.  Are you
saying that with kgdb-lite, `info threads' is completely missing, or does
it just not work correctly with threads (as opposed to heavyweight
processes)?

>  If you consider it an absolutely must, we can do something so that the dirty 
>  part is kept away and info threads almost always works.

Yes, I'd consider `info threads' support a must-have.  I'm rather surprised
that others do not?

