Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWEMMCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWEMMCI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWEMMCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:02:07 -0400
Received: from ns.firmix.at ([62.141.48.66]:62654 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932391AbWEMMCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:02:06 -0400
Subject: Re: Executable shell scripts
From: Bernd Petrovitsch <bernd@firmix.at>
To: Mark Rosenstand <mark@borkware.net>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060513114509.3A90D146AF@hunin.borkware.net>
References: <20060513103841.B6683146AF@hunin.borkware.net>
	 <1147517786.3217.0.camel@laptopd505.fenrus.org>
	 <20060513110324.10A38146AF@hunin.borkware.net>
	 <1147519329.3084.20.camel@gimli.at.home>
	 <20060513114509.3A90D146AF@hunin.borkware.net>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Sat, 13 May 2006 13:56:03 +0200
Message-Id: <1147521363.3084.34.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.187 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-13 at 13:45 +0200, Mark Rosenstand wrote:
> Bernd Petrovitsch <bernd@firmix.at> wrote:
> > On Sat, 2006-05-13 at 13:03 +0200, Mark Rosenstand wrote:
> > [...]
> > > A more useful case is when you setuid the script (and no, this doesn't
> > > need to be running as root and/or executable by all.)
> > 
> > Apart from the permission bug: This has been purposely disabled since it
> > is way to easy to write exploitable shell or other scripts.
> > Use a real programming languages, sudo or a trivial wrapper in C ....
s/languages/language/

And I forgot to mention that a kernel patch is another possibility.

> It isn't a bug on systems that support executable shell scripts.

I never wrote that (or anything which implies that directly).

> Doing security policy based on programming language seems weird at
> best, especially when the only user able to make those decisions is the
> superuser.

It boils down to "how easy is it for root to shoot in the foot"?
And the workarounds are somewhere between trivial and simple.

> Obviously the security-unaware people over at the OpenBSD camp must be
> completely clueless when they don't disallow the superuser to do this.

Of course this doesn't change the level of security but it plays with
the risk ....

> I'm looking forward to the day where I'm no longer allowed to make
> changes to /etc/ld.so.conf because it's a system file.
> 
> Anyway, is it possible to enable this functionality?

Yes.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

