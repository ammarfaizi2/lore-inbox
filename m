Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269203AbUIHXd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269203AbUIHXd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269220AbUIHXd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:33:56 -0400
Received: from [12.177.129.25] ([12.177.129.25]:8388 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S269203AbUIHXc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:32:29 -0400
Message-Id: <200409090035.i890ZYBP016288@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] uml-patch-2.6.7-2 
In-Reply-To: Your message of "Sun, 05 Sep 2004 17:35:36 +0200."
             <200408251746.53523.blaisorblade_spam@yahoo.it> 
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>  <200408251746.53523.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Sep 2004 20:35:34 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade_spam@yahoo.it said:
> * First, please do a "make clean" before releasing the patch. There
> are some  binaries included in it! And also semaphore.c, which is a
> symlink normally. 

I do.  It's just that make clean didn't catch everything.

> * About filehandle_switch: you deleted a line (probably by mistake).
> Reread  more carefully the separate patches you get with quilt: when
> you see the  other attached patch (uml-restore-lost-code.patch),
> you'll agree with me. 

Yuck, I have no idea how that happened.

> However, IMHO, since you cannot close and reopen a pipe, it's
> braindead that  the switch_pipe[] array is an array of filehandles.

Yeah, this is fixed in my 2.6 tree now.

				Jeff

