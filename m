Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbRCFKv1>; Tue, 6 Mar 2001 05:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130389AbRCFKvR>; Tue, 6 Mar 2001 05:51:17 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6148 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130383AbRCFKvC>;
	Tue, 6 Mar 2001 05:51:02 -0500
Message-ID: <20010305231331.L180@bug.ucw.cz>
Date: Mon, 5 Mar 2001 23:13:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Erik Hensema <erik@hensema.xs4all.nl>,
        "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <m3k8648i94.fsf@appel.lilypond.org> <Pine.LNX.3.95.1010305083112.8719A-100000@chaos.analogic.com> <20010305173749.C16345@hensema.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010305173749.C16345@hensema.xs4all.nl>; from Erik Hensema on Mon, Mar 05, 2001 at 05:37:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Somebody must have missed the boat entirely. Unix does not, never
> > has, and never will end a text line with '\r'. It's Microsoft junk
> > that does that, a throwback to CP/M, a throwback to MDS/200.
> 
> Yes, _we_ all know that. However, it's not really intuitive to the user
> getting a 'No such file or directory' on a script he just created. Bash
> doesn't say:
> bash: testscript: Script interpreter not found
> but bash says:
> bash: testscript: No such file or directory
> 
> Maybe we should create a new errno: EINTERPRETER or something like that and
> let the kernel return that instead of ENOENT.

Agreen, EINTEPRETTER would be very nice, plus maybe EDYNLINKER. We
already have 'level 3 stopped', so this should not hurt :-)).
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
