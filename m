Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUKES6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUKES6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 13:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUKES6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 13:58:30 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:47790 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261159AbUKES6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 13:58:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=R2wxJjif5iH2QxOBQpaAbSbybKRm93bSnd0uqAp2np9PWRYsBKRBFqRBN6j4y76L/2fPJz/98H7SXAhKyxJMmoS7VnNqBskjRlu+4itKMaDU+gVpCKqMvTcSz+H/VwB0AbGlduiBK0JVfDumta4MVVbmvor9KeIJBcnKs7d5vvU=
Message-ID: <55f6199c041105105861a25172@mail.gmail.com>
Date: Fri, 5 Nov 2004 13:58:23 -0500
From: Disconnect <dc.disconnect@gmail.com>
Reply-To: Disconnect <dc.disconnect@gmail.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: Possible GPL infringement in Broadcom-based routers
Cc: jp@enix.org, linux-kernel@vger.kernel.org
In-Reply-To: <200411061040.iA6AeZp03452@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411061040.iA6AeZp03452@freya.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(IANAL)

User's can't violate the GPL. Only distributers can. (If said user is
shipping around copies of the integrated kernel+module - ram images,
in this case - they become a distributer.)

Just to reiterate, since this comes up a lot....

You can do WHATEVER you want on your box, with GPL code. You can (as I
recall) even run paid services (web services, for example) on modified
GPL code without releasing any sources. The GPL only covers
-DISTRIBUTION-. As soon as the modified BINARY gets distributed, the
GPL comes into play. Until that happens, there is NO RESTRICTION.

As far as Broadcom (and Tivo, and Linksys, and Sharp, and....) the
only questions are whether the driver is shipped as a module, and
whether or not the majority of the driver existed in a similar,
non-Linux form before integration. (If its not a module, they are
distributing a modified kernel. If it was written specifically for
Linux, the derived-work question comes in to play.)

On Sat, 6 Nov 2004 02:40:35 -0800, Adam J. Richter <adam@yggdrasil.com> wrote:
> >  == David Schwartz
> >> == Jerome Petozzoni
> >> Can Broadcom and the vendors "escape" the obligations of the GPL by
> >> shipping those proprietary drivers as modules, or are they violating the
> >> GPL plain and simple by removing the related source code (and showing
> >> irrelevant code to show "proof of good will") ?
> >
> >        That is a contentious issue that has been debated on this group far too
> >much. In the United States, at least, the answer comes down to the complex
> >legal question of whether the module is a "derived work" of the Linux kernel
> >and whether the kernel as shipped with those modules is a "mere
> >aggregation".
>         I think you're missing the idea that that such drivers are
> _contributory_ infringement to the direct infringement that occurs when
> the user loads the module.  In other words, even for a driver that has
> not a byte of code derived from the kernel, if all its uses involve it
> being loaded into a GPL'ed kernel to form an infringing derivative
> work in RAM by the user committing direct copyright infringement against
> numerous GPL'ed kernel components, then it fails the test of having
> a substantial non-infringing use, as established in the Betamax decision,
> and distributing it is contributory infringement of those GPL'ed
> components of the kernel.

-- 
Disconnect <dc.disconnect@gmail.com>
http://www.gotontheinter.net/
