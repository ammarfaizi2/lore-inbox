Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTDYLSz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 07:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTDYLSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 07:18:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16687 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262914AbTDYLSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 07:18:54 -0400
To: Werner Almesberger <wa@almesberger.net>
Cc: Daniel Phillips <phillips@arcor.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
References: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com>
	<20030424182945.7065812EFF1@mx12.arcor-online.net>
	<20030424201522.G1425@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Apr 2003 05:28:19 -0600
In-Reply-To: <20030424201522.G1425@almesberger.net>
Message-ID: <m1bryuhl4c.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> Daniel Phillips wrote:
> > Open source + Linux + DRM could be used to solve the Quake client-side 
> > cheating problem:
> 
> Yes, but in return you'd be excluded from playing Quake unless
> you're running one of those signed kernels or modules.

In this context, the only thing I know has been openly discussed
is to have a BIOS that includes a public key of my choosing for
authentication.
 
> So, if I, say, want to test some TCP fix, new VM feature, file
> system improvement, etc., none of the applications that rely on
> DRM would work. This doesn't only affect developers, but also
> their potential testers.

Not so because in a general purpose system the owners of the
system control the keys.
 
> Given that most users will just run a distribution's kernel, with
> all the right signatures, companies will not perceive the few
> cases in which their use of DRM causes problems as very important,
> so they will use DRM.

Redhat's kernel is unlikely to get my signature.  Possibly
at some point there will be a web of trust where that will work
but in the first approximation distributors kernels will not
load until I sign them.
 
> Oh, maybe some developers could be granted the privilege of being
> able to sign their own kernels or modules. So if you're part of
> this circle, you'd be fine, right ? No, even this doesn't work,
> because if you'd leak such a key, you'd certainly get sued for
> damages. And I don't think many people would feel overly pleased
> with the idea of being responsible for the safekeeping of the key
> to a multi-million lawsuit. (And besides, this may turn them into
> targets for key theft/robbery/extortion.)
> 
> (There are of course uses of such signatures that would not have
> those problems. E.g. signatures that prove trustworthiness to the
> local user, instead of a remote party.)

Yes.  And there has been some limited discussion on LinuxBIOS list
about implementing these. 

Eric
