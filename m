Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422907AbWBCUE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422907AbWBCUE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422921AbWBCUE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:04:58 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:36364 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422907AbWBCUE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:04:57 -0500
Date: Fri, 3 Feb 2006 21:04:52 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16rc2] compile error
Message-ID: <20060203200452.GA29077@mars.ravnborg.org>
References: <ds08vk$hk$1@sea.gmane.org> <20060203190126.GA28929@mars.ravnborg.org> <200602031447.53193.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602031447.53193.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 02:47:53PM -0500, Gene Heskett wrote:
> >
> >You are hit be an outstanding issue with -rc1 + rc2.
> >When you build as root you will alter /dev/null and in your case it
> >became a regular file.
> 
> That didn't hit me Sam, and I built it as root, running it right now.
First you need to do make clean or make menuconfig to trigger theerror.
Second, not all /dev/null are affected. On my gentoo box it does not
fail.

	Sam
