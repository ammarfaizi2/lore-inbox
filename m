Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUGSOKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUGSOKA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 10:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbUGSOKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 10:10:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:45977 "EHLO scrub.home")
	by vger.kernel.org with ESMTP id S264833AbUGSOJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 10:09:59 -0400
Date: Mon, 19 Jul 2004 16:09:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Chris Lingard <chris@ukpost.com>
cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: PATCH Trivial fix for xconfig
In-Reply-To: <200407191451.55828.chris@ukpost.com>
Message-ID: <Pine.LNX.4.58.0407191607060.20634@scrub.home>
References: <200407191451.55828.chris@ukpost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Jul 2004, Chris Lingard wrote:

> When qt is installed in /usr, then there is no need to set and
> export QTDIR; but make xconfig expects this.

What distribution are you using? This would mean all qt header files are 
directly in /usr/include.

> This patch adds /usr to the script, and removes two header search
> paths that would need QTDIR set.

You just broke xconfig for Debian and RH systems.

bye, Roman
