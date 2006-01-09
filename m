Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWAIQek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWAIQek (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWAIQek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:34:40 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:63492 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964866AbWAIQej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:34:39 -0500
Date: Mon, 9 Jan 2006 17:34:38 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Yaroslav Rastrigin <yarick@it-territory.ru>,
       Kasper Sandberg <lkml@metanurb.dk>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Message-ID: <20060109163437.GA67773@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Lee Revell <rlrevell@joe-job.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Yaroslav Rastrigin <yarick@it-territory.ru>,
	Kasper Sandberg <lkml@metanurb.dk>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	andersen@codepoet.org, linux-kernel@vger.kernel.org
References: <174467f50601082354y7ca871c7k@mail.gmail.com> <200601091403.46304.yarick@it-territory.ru> <1136813783.8412.4.camel@localhost> <200601091656.48355.yarick@it-territory.ru> <1136822827.6659.25.camel@localhost.localdomain> <1136823313.9957.37.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136823313.9957.37.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 11:15:12AM -0500, Lee Revell wrote:
> On Mon, 2006-01-09 at 16:07 +0000, Alan Cox wrote:
> > Currently Linux performance loading large binaries is at least
> > perceptually worse than Windows (some of that is perceptual tricks
> > windows apps pull, some of it real). 
> 
> Would you care to elaborate on this statement?  It's not clear to me how
> perception could differ from reality in this case.  If it seems faster
> doesn't that mean it is faster?

You can have a window opened without being ready to accept input yet
for instance.  XEmacs does that[1] when it opens its window before
parsing the user's configuration which can load a number of things and
hence take a while to run.  "Ok I'm going to open your application"
animations allow to win some perceptual time too.

Humans are fundamentally easy to fool for 1-2 seconds as long as they
have feedback.  Longer gets harder :-)

  OG.

[1] For technical reasons, not perceptual.
