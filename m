Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUD0EnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUD0EnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 00:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUD0EnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 00:43:08 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:15095 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263062AbUD0EnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 00:43:06 -0400
Date: Tue, 27 Apr 2004 00:42:48 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Gilles May <gilles@canalmusic.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <408DCFE9.3040407@canalmusic.com>
Message-ID: <Pine.LNX.4.58.0404270039020.3414@montezuma.fsmlabs.com>
References: <408DC0E0.7090500@gmx.net> <408DCFE9.3040407@canalmusic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Gilles May wrote:

> Carl-Daniel Hailfinger wrote:
>
> >The attached patch blacklists all modules having "Linuxant" or "Conexant"
> >in their author string. This may seem a bit broad, but AFAIK both
> >companies never have released anything under the GPL and have a strong
> >history of binary-only modules.
> >
> >
> Blacklisting modules?!
>
> Oh come on!
> I agree the '\0' trick is not really nice, but blacklisting modules is
> not really better. It's not a functionality that adds anything to the
> kernel.
> If ppl want/have to use that module let them!

Then they should list themselves as proprietory, there will be no problem
loading them in that case. No need to tell fibs.
