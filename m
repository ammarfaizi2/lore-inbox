Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268415AbTGLUBN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 16:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268417AbTGLUBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 16:01:13 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:3001 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S268415AbTGLUBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 16:01:08 -0400
Date: Sat, 12 Jul 2003 22:15:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030712201525.GB446@elf.ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <1058021722.1687.16.camel@laptop-linux> <20030712153719.GA206@elf.ucw.cz> <1058038701.2482.25.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058038701.2482.25.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > That seems like missfeature. We don't want joe random user that is at
> > > > the console to prevent suspend by just pressing Escape. Maybe magic
> > > > key to do that would be acceptable...
> > > 
> > > Magic key? Do you mean a password? I suppose that could be a
> > 
> > Documentation/sysrq.txt. Magic sysrq driver will answer some
> > interesting questions like "how to press esc on the serial line", etc,
> > and it is also /proc configurable.
> 
> Oh so you just be having (eg) to press SysRq-Escape? Isn't that just
> security by obscurity? I'd rather go for the password idea. Sounds like

No, you don't understand.

Magic SysRq is well known mechanism for torturing running
kernel. Kernel hackers have it enabled, security-consious people have
it disabled, and it is /proc-tweakable. It also works in cases like
"the only keyboard on serial terminal", etc. 

> 1.0 tomorrow unless there's anything big in the meantime.

Don't let Esc issue block 1.0, but I do not want to see Esc in 2.5.X.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
