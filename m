Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280897AbRKYP6t>; Sun, 25 Nov 2001 10:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280904AbRKYP6j>; Sun, 25 Nov 2001 10:58:39 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:8402 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280897AbRKYP6d>; Sun, 25 Nov 2001 10:58:33 -0500
Subject: Re: PATCH: gcc3.0.2 workaround for 8139too
From: Ali Akcaagac <ali.akcaagac@stud.fh-wilhelmshaven.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <slrna02427.3v.reneb@orac.aais.org>
In-Reply-To: <1006394515.14661.0.camel@ulixys>
	<1006691124.320.0.camel@ulixys>  <slrna02427.3v.reneb@orac.aais.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 25 Nov 2001 16:57:59 +0100
Message-Id: <1006703880.5039.0.camel@ulixys>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-11-25 at 16:37, Rene Blokland wrote:
> cd d*/n*
> sh ../../foo
> cd /linux
> make
> There you go!

ok, i haven't tested this and don't even know if this works here. i for
now belive that it will work but that error has a _reason_ to happen for
some unknown issues. i'd better go for a cleaner solution right now then
forcing some crashes that _may_ happen because of borked _assembly_ code
that may be generated..

what i am thinking now (and i may be wrong). let's say i compile it your
way everything will be fine no visible errors and so on. now i use that
driver. everything works but under certain circumstances it may jump
into that CASE and crash because the compilers wasn't able to create a
clean code for it.

at least it was a quick solution to solve my personal needs that i
wanted to share with others maybe people not so involved into fixing
stuff.

but thank you. i will try this one out as soon as i update my kernel :)

-- 
Name....: Ali Akcaagac
Status..: Student Of Computer & Economic Science
E-Mail..: mailto:ali.akcaagac@stud.fh-wilhelmshaven.de
WWW.....: http://www.fh-wilhelmshaven.de/~akcaagaa

