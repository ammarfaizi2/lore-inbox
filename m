Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWHVQMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWHVQMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 12:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWHVQMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 12:12:47 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:64229 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1751399AbWHVQMq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 12:12:46 -0400
To: jo@sommrey.de
CC: linux-kernel@vger.kernel.org
In-reply-to: <20060822155949.GA4268@sommrey.de> (message from Joerg Sommrey on
	Tue, 22 Aug 2006 17:59:50 +0200)
Subject: Re: PROBLEM: FUSE unmount breaks serial terminal line
References: <20060820180505.GA18283@sommrey.de> <E1GEuMZ-0004uq-00@dorka.pomaz.szeredi.hu> <20060820212840.GA29855@sommrey.de> <E1GFS4R-0007wJ-00@dorka.pomaz.szeredi.hu> <20060822155949.GA4268@sommrey.de>
Message-Id: <E1GFYmi-0000Ct-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 22 Aug 2006 18:07:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tested both gphoto2 and gtkam without any problems. There is no impact
> on the serial lines.
> 
> NB: The *real* trouble I have is with ntpd and a reference clock
> attached to /dev/ttyS1.  ntpd enters a busy loop reading ttyS1, stops
> working and eats up 100% CPU.  
> 
> Thanks for your investigations.  Any other idea?

Try 'killall -9 gphotofs' and then the 'fusermount -u'.

Does that have the same effect?  If so, after which does the serial
line die?

Miklos
