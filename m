Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265957AbUACLS3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 06:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUACLS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 06:18:29 -0500
Received: from dp.samba.org ([66.70.73.150]:47325 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265957AbUACLR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 06:17:56 -0500
Date: Sat, 3 Jan 2004 14:43:37 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: dtor_core@ameritech.net, vojtech@suse.cz, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6: APM unable to suspend (the 2.6.0-test2 saga
 continues)
Message-Id: <20040103144337.4a121f00.rusty@rustcorp.com.au>
In-Reply-To: <20031231124032.GA367@ucw.cz>
References: <20031005171055.A21478@flint.arm.linux.org.uk>
	<20031230195303.F13556@flint.arm.linux.org.uk>
	<20031230230028.GA778@ucw.cz>
	<200312302045.38501.dtor_core@ameritech.net>
	<20031231124032.GA367@ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003 13:40:33 +0100
Vojtech Pavlik <vojtech@suse.cz> wrote:
> > +#undef MODULE_PARAM_PREFIX
> > +#define MODULE_PARAM_PREFIX /* empty */
> > +
> >  static unsigned int i8042_noaux;
> >  module_param(i8042_noaux, bool, 0);
> 
> Well, I think it might be cleaner to just drop the i8042_ prefix and go
> with the "i8042." prefix if that's the 2.6 way. It'll annoy a couple
> people, but's it's the way to go in the future.

Yeah, unless there's a good reason, it's nicer if there's symmetry so
people can guess how to pass params.

Thanks,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
