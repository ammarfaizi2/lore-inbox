Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161195AbWASLua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbWASLua (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 06:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWASLua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 06:50:30 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:7116 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161195AbWASLu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 06:50:29 -0500
Date: Thu, 19 Jan 2006 12:50:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: maximilian attems <maks@sternwelten.at>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>, Bastian Blank <waldi@debian.org>
Subject: Re: [patch] kbuild: add automatic updateconfig target
In-Reply-To: <20060118194056.GA26532@nancy>
Message-ID: <Pine.LNX.4.61.0601191248070.11765@scrub.home>
References: <20060118194056.GA26532@nancy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 18 Jan 2006, maximilian attems wrote:

> From: Bastian Blank <waldi@debian.org>
> 
> current hack for daily build linux-2.6-git is quite ugly: 
> yes "n" | make oldconfig

What's wrong with 'yes "" | make oldconfig'?
If we added such a make target, it would be basically just this.

bye, Roman
