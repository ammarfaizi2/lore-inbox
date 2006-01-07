Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbWAGLSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWAGLSI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 06:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWAGLSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 06:18:07 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:40586 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030410AbWAGLSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 06:18:06 -0500
Date: Sat, 7 Jan 2006 12:16:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mitchell Blank Jr <mitch@sfgoth.com>
cc: Bob Copeland <email@bobcopeland.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Dave Jones <davej@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: dual line backtraces for i386.
In-Reply-To: <20060107000048.GH84622@gaz.sfgoth.com>
Message-ID: <Pine.LNX.4.61.0601071216310.3578@yvahk01.tjqt.qr>
References: <200601061338_MC3-1-B567-4FDD@compuserve.com>
 <Pine.LNX.4.61.0601062016550.28630@yvahk01.tjqt.qr>
 <b6c5339f0601061133r3653af33h89a0ad7b44f5f94a@mail.gmail.com>
 <20060107000048.GH84622@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Please...
>
>	char space = '\t';
>	[...]
>	printk("%c", space);
>	space = ('\t' + '\n') - space;
>
>Even fewer instructions and actually somewhat understandable.

I see the days of kernelgolf coming...



Jan Engelhardt
-- 
