Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWB0EIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWB0EIi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 23:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWB0EIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 23:08:38 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:1802 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750878AbWB0EIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 23:08:37 -0500
Date: Mon, 27 Feb 2006 05:08:18 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Aaron Brooks <aaron.brooks@sicortex.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: namespace.pl is not CROSS_COMPILE happy
Message-ID: <20060227040818.GA8949@mars.ravnborg.org>
References: <20060208184506.GS11744@sicortex.com> <20060208202251.GA9550@mars.ravnborg.org> <20060227032546.GQ11744@sicortex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227032546.GQ11744@sicortex.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 10:25:46PM -0500, Aaron Brooks wrote:
> Using the fixed path to /usr/bin/{nm,objdump} does not allow
> CROSS_COMPILE environments to use namespace.pl. This patch causes
> namespace.pl to use $NM and $OBJDUMP if defined or fall back to the nm
> and objdump found in the path.
> 
> Signed-off-by: Aaron Brooks <aaron.brooks@sicortex.com>
Applied.

	Sam
