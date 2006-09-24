Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWIXUUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWIXUUl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 16:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWIXUUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 16:20:40 -0400
Received: from mail.aknet.ru ([82.179.72.26]:44303 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932065AbWIXUUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 16:20:40 -0400
Message-ID: <4516E8EE.1000508@aknet.ru>
Date: Mon, 25 Sep 2006 00:22:06 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hugh Dickins <hugh@veritas.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru> <4516B721.5070801@redhat.com> <4516C9D0.3080606@aknet.ru> <200609242206.20446.vda.linux@googlemail.com>
In-Reply-To: <200609242206.20446.vda.linux@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Denis Vlasenko wrote:
> If attacker has malicious loaders on the system,
> the situation is already sort of hopeless.
> Stas, I think noexec mounts are meant to prevent
> _accidental_ execution of binaries/libs from that
> filesystem.
In the past - yes. The problem is that this behaveour
was changed, which is this discussion all about.

> If user wants to execute binary blob from that fs
> bad enough, he will do it. Maybe just by
> copying file first to /tmp.
Not if you mount /tmp with noexec too. At least until
the loader script is written, which is probably some
time ahead. :)

