Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbTBQUXq>; Mon, 17 Feb 2003 15:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267459AbTBQUXp>; Mon, 17 Feb 2003 15:23:45 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:53255 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267446AbTBQUXo>;
	Mon, 17 Feb 2003 15:23:44 -0500
Date: Mon, 17 Feb 2003 21:33:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org,
       rob@osinvestor.com
Subject: Re: Build problem in 2.5.61/sparc
Message-ID: <20030217203336.GA30694@mars.ravnborg.org>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org,
	rob@osinvestor.com
References: <20030217152328.A7540@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217152328.A7540@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 03:23:28PM -0500, Pete Zaitcev wrote:

> [zaitcev@lebethron linux-2.5.61-sparc]$ make oldconfig
> make -f scripts/Makefile.build obj=scripts
> make[1]: *** No rule to make target `scripts/fixdep', needed by `__build'.  Stop.
> make: *** [scripts] Error 2
> [zaitcev@lebethron linux-2.5.61-sparc]$

Looks to me that you are missing scripts/fixdep.c
fixdep.c got updated recently and somehow you may have lost that file in the process?

	Sam
