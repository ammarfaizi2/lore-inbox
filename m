Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752116AbWFWWNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbWFWWNn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbWFWWNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:13:43 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:61327 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1752116AbWFWWNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:13:42 -0400
Date: Sat, 24 Jun 2006 00:12:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Section mismatch warnings
Message-ID: <20060623221217.GA372@mars.ravnborg.org>
References: <Pine.LNX.4.61.0606231938080.26864@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606231938080.26864@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 07:40:12PM +0200, Jan Engelhardt wrote:
> Hello,
> 
> 
> as others have already seen to, 2.6.17 spits out a lot of section mismatch 
> warnings on modpost. Some of them have may already been addressed; here is 
> the output I get when MODPOST starts to run during the compile process of 
> an almost-completely-compiled kernel. Need .config?

All the .smp_locks related warnings are gone when I get the kbuild.git
tree pushed linus wise. Needs to spend only an hour or so before it is
ready and will do so during the weekend.

	Sam
