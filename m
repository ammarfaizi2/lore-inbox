Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266803AbUGLMN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266803AbUGLMN3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 08:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUGLMN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 08:13:29 -0400
Received: from mail.dif.dk ([193.138.115.101]:29675 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266803AbUGLMN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 08:13:27 -0400
Date: Mon, 12 Jul 2004 14:11:37 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, jmerkey@comcast.net,
       Pete Harlan <harlan@artselect.com>, linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
In-Reply-To: <4d8e3fd304071203204c51f6c4@mail.gmail.com>
Message-ID: <Pine.LNX.4.56.0407121407180.24721@jjulnx.backbone.dif.dk>
References: <070920041920.2370.40EEEFFD000B341B000009422200763704970A059D0A0306@comcast.net>
 <40EF797E.6060601@namesys.com> <20040710083347.GC6386@redhat.com>
 <40F02963.5040500@namesys.com> <20040710174432.GA18719@infradead.org>
 <40F02E05.8090401@namesys.com> <4d8e3fd304071203204c51f6c4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004, Paolo Ciarrocchi wrote:

> On Sat, 10 Jul 2004 10:57:25 -0700, Hans Reiser <reiser@namesys.com> wrote:
> > Christoph Hellwig wrote:
> [...]
> > Lindows does it right.
>
> I dunno how Lindows manage the release process,
> but as I already wrote in a different thread, I don't unserstand why
> the linux kernel release process can't be supported by a suite of test
> that has to be passed before being released a new -rc or final
> version.
>
> It seems there are now the all the tools we need but we are note using
> them to manage the releases.
>
> I'm referring to LTP, compile stats and regression test from OSDL.
>

Just wanted to add my 0.02euro - To me it sounds like a good idea to have
a testsuite with "must pass these" tests that official kernel releases get
tested against.. maybe just the final -rc's before a new stable release.
What should be in the test suite and how it should be
maintained/updated will of course be a matter of debate, but
the basic idea that if release candidates doesn't pass the basic test
suite, then another release candidate must surface sounds very sane to me.

--
Jesper Juhl <juhl-lkml@dif.dk>

