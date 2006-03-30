Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWC3HY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWC3HY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWC3HY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:24:28 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:51210 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751212AbWC3HY2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:24:28 -0500
To: Rob Landley <rob@landley.net>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Eric Piel <Eric.Piel@tremplin-utc.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
Subject: Re: [OT] Non-GCC compilers used for linux userspace
References: <200603141619.36609.mmazur@kernel.pl>
	<200603281647.06020.rob@landley.net> <87irpxvtb3.fsf@hades.wkstn.nix>
	<200603292036.38937.rob@landley.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: if SIGINT doesn't work, try a tranquilizer.
Date: Thu, 30 Mar 2006 08:24:05 +0100
In-Reply-To: <200603292036.38937.rob@landley.net> (Rob Landley's message of
 "Wed, 29 Mar 2006 20:36:38 -0500")
Message-ID: <87k6actmy2.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2006, Rob Landley whispered secretively:
> Actually according to the changelog version 0.9.21 grew support for ARM, and I 
> believe it supports some other platforms too.

That's... impressive. Of course the more generality it grows the slower
it must necessarily become, although it'll be a while until its IR is as
bloated and thus as slow as GCC's... (GCC's only slow because of cache
effects, really).

> The result was qemu, which sort of compiles machine code to machine code 
> dynamically, and which has taken up a large chunk of his time ever since.  
> (The speed of tcc development has tailed off noticeably since, but he still 
> spends a little time on it, and there are other developers...)

Well, I'd rather he spent time on qemu than tcc; there are other C compilers
but there's nothing quite like qemu (bochs doesn't work very well, valgrind
is similar in essence but very different in operation...)

>> > That aims for full c99 and is already implementing a lot of gcc stuff
>> > too.
>>
>> Good for it, as long as it doesn't go on to define __GNUC__ like icc did
>> at one point (even though it doesn't implement all GCC
>> extensions)... but Fabrice is sane so I doubt he'd do anything that
>> loopy.
> 
> That's more a header issue anyway.  That's the uClibc developers problem. :)

;)

-- 
`Come now, you should know that whenever you plan the duration of your
 unplanned downtime, you should add in padding for random management
 freakouts.'
