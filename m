Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291610AbSBTCRm>; Tue, 19 Feb 2002 21:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291613AbSBTCRd>; Tue, 19 Feb 2002 21:17:33 -0500
Received: from traven.uol.com.br ([200.231.206.184]:36854 "EHLO
	traven.uol.com.br") by vger.kernel.org with ESMTP
	id <S291610AbSBTCRW>; Tue, 19 Feb 2002 21:17:22 -0500
Date: Tue, 19 Feb 2002 23:17:14 -0300 (BRT)
From: Jean Paul Sartre <sartre@linuxbr.com>
To: Christoph Pittracher <pitt@gmx.at>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sis_malloc / sis_free
In-Reply-To: <200202200237.28577@pitt4u.2y.net>
Message-ID: <Pine.LNX.4.40.0202192311330.13176-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Christoph Pittracher wrote:

> Hello!

> Yes, the sisfb/drm code has some design lacks.
> Another lack is the necessary memory offset between framebuffer/drm and
> the X driver (see http://www.webit.at/~twinny/linuxsis630.shtml for
> details).

	Oh, okay. Should that memory offset be a source of processor time
waste for allocating memory when switching through FB and X, for an
example? If so, sharing the code (instead of duplicating it) is the ideal
approach.

> I don't think that it would be a problem to duplicate the code. the
> sis_malloc / sis_free functions seems quite stable. I don't think that
> there will be big updates for this code.

	Hmm, but as you stated, I do not think code duplication should be
the best approach.

> Thomas Winischhofer <tw@webit.com> is working on that SiS stuff for
> about 2 months. I think it would be best if you contact him and ask
> what he thinks about that. I know that he said it would be a good idea
> to seperate the sisfb and sis_drm code but he doesn't have enough time
> to do it...

	If I have such time, I'll contact him. But for the moment, if the
code does not compile (still with 2.4.18-rc2-ac1) I'll duplicate the code
to get it working until a better solution raises.

	Regards,
	Cesar Suga <sartre@linuxbr.com>


