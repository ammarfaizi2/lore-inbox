Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUFXGRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUFXGRU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 02:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbUFXGRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 02:17:20 -0400
Received: from havoc.gtf.org ([216.162.42.101]:53466 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262190AbUFXGRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 02:17:18 -0400
Date: Thu, 24 Jun 2004 02:16:42 -0400
From: David Eger <eger@havoc.gtf.org>
To: Kalin KOZHUHAROV <kalin@ThinRope.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Alphabet of kernel source
Message-ID: <20040624061642.GA8506@havoc.gtf.org>
References: <20040623140628.3f1abfe9@lembas.zaitcev.lan> <20040623214653.GA29728@havoc.gtf.org> <40DA01C1.2030102@ThinRope.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DA01C1.2030102@ThinRope.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 07:18:41AM +0900, Kalin KOZHUHAROV wrote:
> >http://www.yak.net/random/linux-2.6.4-utf8-cleanup-cstrings2utf8.diff
> Some degree symbols and microseconds... and names.
> I remember having problems with lm-sensors trying to print degrees, how did 
> they fight the problem?

I assume the local charset on the machines where they cat /proc/blah are 
running in ISO Latin 1 ;-)

> >http://www.yak.net/random/linux-2.6.4-utf8-cleanup-jp.diff
> Ok, this Japanese is only in the comments.
> I can translate that in no time and fix this diff.

actually, I'm pretty sure the diff is correct against 2.6.4 - the bytes
should all be correct, as I checked it with someone who works with
said files...

> I guess you had some kind of script, can you try it on vanilla 2.6.7, 
> plesae, and post results.

I will regenerate the patches if someone in charge (Linus or Andrew) 
actually wants them.

-dte
