Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265706AbSKFPRD>; Wed, 6 Nov 2002 10:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265707AbSKFPRD>; Wed, 6 Nov 2002 10:17:03 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:63241 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265706AbSKFPRC>; Wed, 6 Nov 2002 10:17:02 -0500
Date: Wed, 6 Nov 2002 16:10:12 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] kconfig: Move config targets and lxdialog
In-Reply-To: <20021104201442.GA8542@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0211061607150.6949-100000@serv>
References: <20021104201442.GA8542@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 4 Nov 2002, Sam Ravnborg wrote:

> Played with the idea to shuffle a little around with stuff.
> 1) lxdialog is solely used for kconfig, so move it below scripts/kconfig
> 2) Move handling of all config targets to scripts/kconfig/Makefile
> 	This simplifies top-level makefile,
> 	and the actual rules is nicer as a side effect.

I like 2), but I'm not sure about 1). Using $(obj)/../lxdialog/
shoudn't be a problem either?

bye, Roman

