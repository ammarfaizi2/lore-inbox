Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWIYR5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWIYR5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWIYR5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:57:23 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:28900 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1751411AbWIYR5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:57:22 -0400
Date: Mon, 25 Sep 2006 20:02:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@mars.ravnborg.org>
Subject: Re: [PATCH 13/28] kbuild: make -rR is now default
Message-ID: <20060925180238.GC2490@uranus.ravnborg.org>
References: <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <Pine.LNX.4.61.0609250824020.18552@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609250824020.18552@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 08:24:31AM +0200, Jan Engelhardt wrote:
> 
> >Subject: [PATCH 13/28] kbuild: make -rR is now default
> >
> >Do not specify -rR anymore - it is default.
> 
> What do you mean, it is default? Did upstream (GNU make) enable it by 
> default?
The top-level Makefiles set MAKEFLAGS variables so you
do not need to specify "$(MAKE) -rR" to get optimal performance.

	Sam
