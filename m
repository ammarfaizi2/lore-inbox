Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVB0CTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVB0CTI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 21:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVB0CTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 21:19:07 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:48913 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261329AbVB0CTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 21:19:04 -0500
Date: Sun, 27 Feb 2005 03:18:59 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Matthias Kunze <Matthias.Kunze@gmx-topmail.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] config option for default loglevel
Message-ID: <20050227021859.GA7619@pclin040.win.tue.nl>
References: <20050226190556.0def242c.Matthias.Kunze@gmx-topmail.de> <20050226154505.43889139.akpm@osdl.org> <20050227030431.46496c7a.Matthias.Kunze@gmx-topmail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050227030431.46496c7a.Matthias.Kunze@gmx-topmail.de>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: SINECTIS: kweetal.tue.nl 1114; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 03:04:31AM +0100, Matthias Kunze wrote:

+config DEFAULT_CONSOLE_LOGLEVEL

You do not want to add yet another config option.
Config options are used to select or deselect major subsystems,
or support for specific hardware.
Not to tweak variables.

Adding more config variables is not an improvement.

There are many ways to set the loglevel from user space.
You add one on the command line - maybe useful in case more
output is needed when the kernel crashes in early boot.
I see no justification for DEFAULT_CONSOLE_LOGLEVEL.

Andries
