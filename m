Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423903AbWKHXFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423903AbWKHXFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423879AbWKHXFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:05:33 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:39347 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S1423903AbWKHXFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:05:32 -0500
Date: Thu, 9 Nov 2006 00:05:30 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Message-ID: <20061108230530.GA25927@rhlx01.hs-esslingen.de>
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com> <1163024531.3138.406.camel@laptopd505.fenrus.org> <9a8748490611081440u6ba6c541h1038ac1e530e2839@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490611081440u6ba6c541h1038ac1e530e2839@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 08, 2006 at 11:40:27PM +0100, Jesper Juhl wrote:
> Let me make one very clear statement first: -stabel is a GREAT think
> and it is working VERY well.
> That being said, many of the fixes I see going into -stable are
> regression fixes. Maybe not the majority, but still, regression fixes
> going into -stable tells me that the kernel should have seen more
> testing/bugfixing before being declared a stable release.

Nice theory, but of course I'm pretty sure that it wouldn't work
(as has been said numerous time before by other people).

You cannot do endless testing/bugfixing, it's a psychological issue.
If you do that, then you end up with -preXX (or worse, -preXXX)
version numbers, which would cause too many people to wait and wait
and wait with upgrading until "that next stable" kernel version
finally becomes available.
IOW, your tester base erodes, awfully, and development progress stalls.

You *have* to release a new ""stable"" version rather fast (the .0 one)
so that people will have that "new shiny version, get it while it's hot!"
feeling and will realize rather quickly that that new version
is all crap again after all and report their unhappiness.
That will lead to lots of -stable bug fixes which will then result in
a very stable actual version once you reach x.y.z.15 or so.

Capito? :)

(well, that's at least how I'm seeing it; correct me if I'm wrong)

Andreas Mohr
