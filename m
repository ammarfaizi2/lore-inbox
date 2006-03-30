Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWC3XSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWC3XSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 18:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWC3XSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 18:18:34 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:62421
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751132AbWC3XSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 18:18:33 -0500
From: Rob Landley <rob@landley.net>
To: Nix <nix@esperi.org.uk>
Subject: Re: [OT] Non-GCC compilers used for linux userspace
Date: Thu, 30 Mar 2006 18:16:47 -0500
User-Agent: KMail/1.8.3
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Eric Piel <Eric.Piel@tremplin-utc.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl> <200603301526.14744.rob@landley.net> <87odznsi98.fsf@hades.wkstn.nix>
In-Reply-To: <87odznsi98.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603301816.47811.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 March 2006 5:02 pm, Nix wrote:
> > Keep in mind that the main use of tcc these days is to turn c into a
> > scripting language.  Just start your C file with
> >
> > #!/usr/bin/tcc -run
>
> I feel distinctly queasy. (I can't easily think of a less suitable language
> for scripting than C, either: perhaps COBOL...)

No, the queasy bit is when you realize that you can stick library linkage 
directives on that command line and thus you can dynamically compile and run 
X apps.

They have examples of doing this. :)

> > And notice that #! is a preprocessor comment line as far as tcc is
> > concerned. :)
>
> I noticed that, but I didn't think anyone actually *used* tcc for this.

It's not exactly "what it's for", but it's up there.

Rob
-- 
Never bet against the cheap plastic solution.
