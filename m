Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWGQOem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWGQOem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWGQOem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:34:42 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:54440 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750802AbWGQOel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:34:41 -0400
Date: Mon, 17 Jul 2006 16:33:47 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Al Boldi <a1426z@gawab.com>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: "Why Reuser 4 still is not in" doc
In-Reply-To: <200607171425.19816.a1426z@gawab.com>
Message-ID: <Pine.LNX.4.61.0607171631460.5733@yvahk01.tjqt.qr>
References: <200607171425.19816.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Using this as an argument against plug-ins is a bit strange.  I suppose 
>somebody could go overboard and use plug-ins to implement a subKernel.  
>Would this then imply that plug-ins are wrong?
>
Ok, I've read some other threads too and so this claim should be adjusted:

Writing a plugin (not necessarily r4 specific) that changes the semantics 
of objects based on context (i.e. turning a file into a dir) is a bad idea 
IMHO.
Actually, BSD has this double-semantic to a limited degree: you can call 
`/usr/bin/vi /usr/bin` and get some binary representation of readdir.



Jan Engelhardt
-- 
