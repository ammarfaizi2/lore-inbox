Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285326AbRL2TP3>; Sat, 29 Dec 2001 14:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285303AbRL2TPU>; Sat, 29 Dec 2001 14:15:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5381 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285269AbRL2TPO>; Sat, 29 Dec 2001 14:15:14 -0500
Date: Sat, 29 Dec 2001 11:12:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Legacy Fishtank <garzik@havoc.gtf.org>
cc: Benjamin LaHaise <bcrl@redhat.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: State of the new config & build system
In-Reply-To: <20011228195914.A14127@havoc.gtf.org>
Message-ID: <Pine.LNX.4.33.0112291111130.23542-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Dec 2001, Legacy Fishtank wrote:
>
> A per-driver metadata file is IMHO clearly the preferred solution.

Note that it doesn't need to be per-driver: there are good reasons to have
"combined" files too. For example, things like "architecture config" could
all be in one file, along with similar drivers (ie "3com network devices",
whatever).

		Linus

