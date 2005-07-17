Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVGQTjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVGQTjp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 15:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVGQTjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 15:39:45 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:17700 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261247AbVGQTjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 15:39:44 -0400
Date: Sun, 17 Jul 2005 21:04:36 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, stable@kernel.org
Subject: Re: kbuild: When checking depmod version, redirect stderr
Message-ID: <20050717210436.GA27257@mars.ravnborg.org>
References: <20050715145636.GU7741@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050715145636.GU7741@smtp.west.cox.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 07:56:36AM -0700, Tom Rini wrote:
> When running depmod to check for the correct version number, extra
> output we don't need to see, such as "depmod: QM_MODULES: Function not
> implemented" may show up.  Redirect stderr to /dev/null as the version
> information that we do care about comes to stdout.

Applied, thanks.

	Sam
