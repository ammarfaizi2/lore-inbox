Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSFDE0Y>; Tue, 4 Jun 2002 00:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316221AbSFDE0X>; Tue, 4 Jun 2002 00:26:23 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:41993 "EHLO
	marc2.theaimsgroup.com") by vger.kernel.org with ESMTP
	id <S316217AbSFDE0W>; Tue, 4 Jun 2002 00:26:22 -0400
Date: Tue, 4 Jun 2002 00:26:23 -0400
Message-Id: <200206040426.g544QNA28367@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: please kindly get back to me
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-06-03, J Sloan <joe@tmsusa.com> wrote:

> The thing with linux/unix "virii" is, they
> are actually for the most part trojans -
> they've been in labs for years, the problem
> is that there is no suitable transport vector!

> You'd have to dupe an unwitting superuser
> (now there's a dangerous combination) into
> running the "virus" by hand - sort of like
> the "honor system" virus....

...You mean like, get them to run './configure' ?[1][2]
...Or installing an RPM with trojanned binaries or install-time scripts,
without checking a signature?[3]

Unfortunately that's all too easy.  Viruses, no.  Malware, you bet.  We
can't get too complacent while laughing at the virus phenomenon.

[1] http://marc.theaimsgroup.com/?l=bugtraq&m=102233939226053&w=2
    http://marc.theaimsgroup.com/?l=bugtraq&m=102285523803434&w=2
[2] They don't have to do this as root, either.  If they do it from an
    account that can escalate privileges (i.e. is allowed to su or sudo)
    then it's game over anyway, albeit with more steps.
[3] And of course signatures are useless if the signer was owned first.
    Probably major distros are reasonably safe[4], but not Joe Random who
    produces packages and distributes them...
[4] They're not out to get you; they've already got you:
    http://www.acm.org/classics/sep95/

--
Hank Leininger <hlein@progressive-comp.com>
ALL YOUR BASE ARE BELONG TO KEN THOMPSON
