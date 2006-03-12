Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWCLWni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWCLWni (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWCLWni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:43:38 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:4882 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751079AbWCLWnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:43:37 -0500
Date: Sun, 12 Mar 2006 23:43:28 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix time ordering of writes to .kconfig.d and include/linux/autoconf.h
Message-ID: <20060312224328.GD23326@mars.ravnborg.org>
References: <44104012.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44104012.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 02:47:46PM +0100, Jan Beulich wrote:
> Since .kconfig.d is used as a make dependency of include/linux/autoconf.h, it
> should be written earlier than the header file, to avoid a subsequent rebuild
> to consider the header outdated.

Thanks Jan. I assume you saw this in reality?
Applied.

	Sam
