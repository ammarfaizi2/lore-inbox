Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWAUXAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWAUXAU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 18:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWAUXAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 18:00:20 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:61457 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751219AbWAUXAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 18:00:19 -0500
Date: Sun, 22 Jan 2006 00:00:07 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, Olaf Hering <olh@suse.de>
Subject: Re: cc-version not available to change EXTRA_CFLAGS
Message-ID: <20060121230007.GB13756@mars.ravnborg.org>
References: <200601212207.49483.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601212207.49483.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 10:07:42PM +0300, Andrey Borzenkov wrote:
> 
> Which raises the question - I believed, we support Intel CC for kernel 
> compilation? Or was just just a dream?

We have include/linux/compiler-intel.h as the only artifact to support
the Intel compiler.
In all other places we assume gcc - but Intel tries hard to be gcc
alike.

	Sam
