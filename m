Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbSKBXZh>; Sat, 2 Nov 2002 18:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbSKBXZg>; Sat, 2 Nov 2002 18:25:36 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:48906 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261504AbSKBXZg>;
	Sat, 2 Nov 2002 18:25:36 -0500
Date: Sun, 3 Nov 2002 00:29:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Kernel GUI config
Message-ID: <20021102232956.GC16498@mars.ravnborg.org>
Mail-Followup-To: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20021102231435.GA2384@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021102231435.GA2384@werewolf.able.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 12:14:35AM +0100, J.A. Magallón wrote:
> To reduce implementation efforts (and bug chasing), as someone said, you
> can take all the current parts toolkit-independent (parsers, etc.) from
> qconf and split them in a library.
If you look into scripts/kconfig you will find a shared library: libkconfig.so
Thats exactly what you ask for. A library containing the back-end.
The current frontends: oldconfig, menuconfig and xconfig are based on that.

Before getting into too much discussing about how to integrate a new
front-end lets see it.

	Sam
