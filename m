Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSHMJ3z>; Tue, 13 Aug 2002 05:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSHMJ3z>; Tue, 13 Aug 2002 05:29:55 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:45328 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314138AbSHMJ3z>; Tue, 13 Aug 2002 05:29:55 -0400
Date: Tue, 13 Aug 2002 11:32:52 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg Banks <gnb@alphalink.com.au>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Peter Samuelson <peter@cadcamlab.org>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [patch] config language dep_* enhancements
In-Reply-To: <3D587DFC.76F2C778@alphalink.com.au>
Message-ID: <Pine.LNX.4.44.0208131111460.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 13 Aug 2002, Greg Banks wrote:

> > This doesn't has be
> > very painful, I have a tool that can convert most of the current config
> > into whatever you want.
>
> The problem is deciding what the original rules were supposed to mean, and
> then reproducing that behaviour exactly in the new language.  The alternative
> is fixing the problems as we convert, but then we end up with CML2 and the
> "there's no way to verify the rulebase is the same" argument.

My only requirement is that the resulting rulebase is usable and roughly
the same, some small bugs are IMO acceptable.
CML2 has more problems than this. It's a very flexible but also very
complex language, which makes it hard to use. It was also not very wise to
create a complete new and different rulebase, which made it very hard to
compare both.

bye, Roman

