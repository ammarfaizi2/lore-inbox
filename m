Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVDFM1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVDFM1p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVDFM1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:27:45 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:17550 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262187AbVDFM1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 08:27:43 -0400
Date: Wed, 6 Apr 2005 14:27:51 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Renate Meijer <kleuske@xs4all.nl>
Cc: Blaisorblade <blaisorblade@yahoo.it>, jdike@karaya.com,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Greg KH <gregkh@suse.de>
Subject: Re: [08/08] uml: va_copy fix
Message-ID: <20050406122750.GE7031@wohnheim.fh-wedel.de>
References: <20050405164539.GA17299@kroah.com> <20050405164815.GI17299@kroah.com> <c8cb775b8f5507cbac1fb17b1028cffc@xs4all.nl> <200504052053.20078.blaisorblade@yahoo.it> <7aa6252d5a294282396836b1a27783e8@xs4all.nl> <20050406113233.GD7031@wohnheim.fh-wedel.de> <14410feafdb3a83e1ae457b93e593b81@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14410feafdb3a83e1ae457b93e593b81@xs4all.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 April 2005 14:04:39 +0200, Renate Meijer wrote:
>
> >And you did read this thread as well, right?
> >http://kerneltrap.org/node/4126
> 
> <quote>
> Things seem to have improved a bit lately. The gcc-3.x series was
> basically not worth it for plain C until 3.3 or so.
> </quote>
> 
> Yes. You did read the actual data as produced by that guy from Suse, 
> did you? In the past,
> people may have justly stuck to (e.g.) 2.95.3, however, support for 
> that version now starts to
> require dependencies on compiler internals. This is one argument in 
> favor of dropping support
> for that version, or at least not to spread compiler dependent stuff 
> all over the code.

Fyi, another fact that was missing from the quoted thread: gcc 2.95
catches bugs that 3.x compilers simply miss.  Support for the old
compiler is more work, no doubt, and at times requires to work around
plain compiler bugs as well.  But there is some return on investment.

Is it worth the effort?  Not sure.  But the "it's old, drop support
for it" argument just doesn't cut it and it doesn't get any better by
repetition.

Jörn

-- 
Schrödinger's cat is <BLINK>not</BLINK> dead.
-- Illiad
