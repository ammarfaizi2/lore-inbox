Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267021AbSLPSw2>; Mon, 16 Dec 2002 13:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSLPSw2>; Mon, 16 Dec 2002 13:52:28 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:8975 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267021AbSLPSva>;
	Mon, 16 Dec 2002 13:51:30 -0500
Date: Mon, 16 Dec 2002 19:59:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where is this printk?
Message-ID: <20021216185925.GA6772@mars.ravnborg.org>
Mail-Followup-To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org
References: <200212161938.28306.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212161938.28306.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 07:43:24PM +0100, Marc-Christian Petersen wrote:
> Hi all,
> 
> does anyone know where this is printed out in kernel source?
> 
> Linux version 2.4.20 (root@codeman) (gcc version 2.95.4 20011002 (Debian 
> prerelease)) #1 Mon Dec 16 16:54:44 CET 2002

init/version.c, see definition of linux_banner.
Defines used by version.c is made by scripts/mkcompile_h

	Sam
