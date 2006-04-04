Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWDDPyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWDDPyf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 11:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWDDPyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 11:54:35 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:21636 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750721AbWDDPye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 11:54:34 -0400
Date: Tue, 4 Apr 2006 17:54:23 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mike Hearn <mike@plan99.net>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
In-Reply-To: <4431A93A.2010702@plan99.net>
Message-ID: <Pine.LNX.4.61.0604041752070.14611@yvahk01.tjqt.qr>
References: <4431A93A.2010702@plan99.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  ./configure --prefix=/proc/self/exedir/..
>
> So .... does anybody have any objections to this? Would you like to see it go
> in? Speak now or forever hold your peace! :)
>

(Obligatory answer from fs/proc/base.c):
        /*
         * Yes, it does not scale. And it should not. Don't add
         * new entries into /proc/<tgid>/ without very good reasons.
         */


No objections. We'll see what it can buy us, when we get the chance 
to use it. If it sucks, it will find its way out again. :)


Jan Engelhardt
-- 
