Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUBDAz0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbUBDAz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:55:26 -0500
Received: from gprs156-172.eurotel.cz ([160.218.156.172]:2177 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263777AbUBDAzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:55:23 -0500
Date: Wed, 4 Feb 2004 01:55:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: the grugq <grugq@hcunix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040204005514.GB253@elf.ucw.cz>
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <20040204004318.GA253@elf.ucw.cz> <4020416B.3050301@hcunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4020416B.3050301@hcunix.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Well, doing it on-demand means one less config option, and possibility
> >to include it into 2.7... It should be easy to have tiny patch forcing
> >that option always own for your use...
> 
> Works for me. Should I implement the chattr 's' handling then for the 
> data blocks? Or do you think it should also include the meta-data 
> deletion as well?

[Perhaps I got confused somewhere in between]

I think chattr +s file should be zeroed, along with its metadata. I
thought your patch already does that. If not, doing that would be
great...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
