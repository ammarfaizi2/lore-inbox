Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWC3WDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWC3WDe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 17:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWC3WDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 17:03:34 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:24332 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751041AbWC3WDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 17:03:33 -0500
To: Rob Landley <rob@landley.net>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Eric Piel <Eric.Piel@tremplin-utc.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
Subject: Re: [OT] Non-GCC compilers used for linux userspace
References: <200603141619.36609.mmazur@kernel.pl>
	<200603292036.38937.rob@landley.net> <87k6actmy2.fsf@hades.wkstn.nix>
	<200603301526.14744.rob@landley.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: an inspiring example of form following function... to Hell.
Date: Thu, 30 Mar 2006 23:02:59 +0100
In-Reply-To: <200603301526.14744.rob@landley.net> (Rob Landley's message of
 "Thu, 30 Mar 2006 15:26:14 -0500")
Message-ID: <87odznsi98.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Rob Landley suggested tentatively:
> On Thursday 30 March 2006 2:24 am, Nix wrote:
>> On Wed, 29 Mar 2006, Rob Landley whispered secretively:
>> > Actually according to the changelog version 0.9.21 grew support for ARM,
>> > and I believe it supports some other platforms too.
>>
>> That's... impressive. Of course the more generality it grows the slower
>> it must necessarily become,
> 
> Not if compliation speed is the primary explicit design goal from day one, and 
> they regression test with that in mind.

Aaah.

> Keep in mind that the main use of tcc these days is to turn c into a scripting 
> language.  Just start your C file with
> 
> #!/usr/bin/tcc -run

I feel distinctly queasy. (I can't easily think of a less suitable language for
scripting than C, either: perhaps COBOL...)

> And notice that #! is a preprocessor comment line as far as tcc is 
> concerned. :)

I noticed that, but I didn't think anyone actually *used* tcc for this.

-- 
`Come now, you should know that whenever you plan the duration of your
 unplanned downtime, you should add in padding for random management
 freakouts.'
