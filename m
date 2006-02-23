Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWBWEEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWBWEEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 23:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWBWEEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 23:04:52 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:56594 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750782AbWBWEEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 23:04:52 -0500
Date: Thu, 23 Feb 2006 05:04:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Beulich <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] version.h should depend on .kernelrelease
Message-ID: <20060223040446.GA9085@mars.ravnborg.org>
References: <200602221329.04547.jbeulich@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602221329.04547.jbeulich@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 01:29:04PM +0100, Jan Beulich wrote:
> Rebuilding a previously built tree while using make's -j options from time to
> time results in the version.h check running at the same time as the updating
> of .kernelrelease, resulting in UTS_RELEASE remaining an empty string (and as
> a side effect causing the entire kernel to be rebuilt).

Thanks Jan, applied to my kbuild.git tree.

	Sam
