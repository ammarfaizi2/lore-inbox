Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbULROaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbULROaO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 09:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbULROaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 09:30:14 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:41359 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261162AbULRO37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 09:29:59 -0500
Date: Sat, 18 Dec 2004 15:29:55 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: New System call & Kernel compilation
In-Reply-To: <20041218141935.GA15970@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0412181527090.32157@yvahk01.tjqt.qr>
References: <20041217102631.43898.qmail@web52106.mail.yahoo.com>
 <20041218141935.GA15970@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>   After adding a new system call, should we have to
>> recompile the whole kernel? can anyone help me
>> regarding this?
>
>You do not need to do a 'make clean'. Simply executing make will suffer 
>since kbuild has track of all dependencies.
>
>Assuming 2.6 kernel!

Even in 2.4 you do not need make clean. make dep should suffice if you changed 
some includes.

I dislike how many FAQs and tutorials always add "do a make clean"... that 
requires you to recompile everything (read: may take "some time", when in 
practice you only need a few things (i'm speaking generally, any app is 
considered).


Jan Engelhardt
-- 
ENOSPC
