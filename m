Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314463AbSEBOto>; Thu, 2 May 2002 10:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314490AbSEBOtn>; Thu, 2 May 2002 10:49:43 -0400
Received: from conn6m.toms.net ([64.32.246.219]:36006 "EHLO conn6m.toms.net")
	by vger.kernel.org with ESMTP id <S314463AbSEBOtm>;
	Thu, 2 May 2002 10:49:42 -0400
Date: Thu, 2 May 2002 10:49:41 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
To: linux-kernel@vger.kernel.org
Subject: module choices affecting base kernel size???
Message-ID: <Pine.LNX.4.44.0205021043200.8024-100000@conn6m.toms.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changing all =m to =n in my config makes a 4K difference in the kernel size.

But, the kernel compiled with them off still seems to load the modules fine.

Why is there such a size difference in the static part and what do I risk if
I mix a kernel compiled with the modules off with said modules?  What stuff
is actually being compiled into the static part because of the modules I
choose?  Doesn't it defeat the point of modules to have dependencies or even
effects on the static part caused by the choice of module compilation?


-Tom

