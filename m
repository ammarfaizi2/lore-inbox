Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318729AbSIKLsy>; Wed, 11 Sep 2002 07:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318735AbSIKLsy>; Wed, 11 Sep 2002 07:48:54 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:40971 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318729AbSIKLsx>; Wed, 11 Sep 2002 07:48:53 -0400
Date: Wed, 11 Sep 2002 13:51:52 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.5
In-Reply-To: <20020911131740.A17141@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0209111344210.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 11 Sep 2002, Sam Ravnborg wrote:

> make xconfig
> - Do some selections
> - Use mouse to select save icon on tool-bar
> - File|Quit
> ->Save Configuration? Press yes
> End result is an empty .config file

I've seen it once too, but I couldn't remember how to reproduce it, but I
now know what happens. A second save goes wrong if nothing changed since
the last save. It's easy to fix, thanks for finding this.

bye, Roman

