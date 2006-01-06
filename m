Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWAFTz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWAFTz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWAFTz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:55:57 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:49414 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932463AbWAFTz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:55:56 -0500
Date: Fri, 6 Jan 2006 20:55:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ga?l UTARD <gael.utard@seanodes.com>
Cc: kai@germaschewski.name, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: fix external modules build
Message-ID: <20060106195526.GB16130@mars.ravnborg.org>
References: <200601051146.58824.gael.utard@seanodes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601051146.58824.gael.utard@seanodes.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 11:46:58AM +0100, Ga?l UTARD wrote:
> The patch 2dd34b488a99135ad2a529e33087ddd6a09e992a breaks external modules 
> build since include/linux/autoconf.h is not found in the header files 
> directories.

Hi Gael.

Can you please elaborate a little more of what error you see (show
output of make with V=1 option.
Also try to show the directory structure you use.

Reason for this is that is works for me - so please let me know what you
exactly try to fix.

Thanks,
	Sam
