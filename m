Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275441AbTHIXNa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 19:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275436AbTHIXM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 19:12:27 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:53732 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S275435AbTHIXMY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 19:12:24 -0400
From: pavel@ucw.cz
To: "=?ISO-8859-1?Q?Flameeyes?=" <dgp85@users.sourceforge.net>
Cc: "=?ISO-8859-1?Q?LKML?=" <linux-kernel@vger.kernel.org>,
       "=?ISO-8859-1?Q??= =?ISO-8859-1?Q?LIRC_list?=" 
	<lirc-list@lists.sourceforge.net>
Subject: =?ISO-8859-1?Q?Re:_[PATCH]_lirc_for_2.5/2.6_kernels_?=
Date: 10 Aug 2003 01:11:31 +0000
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20030809231326.BCA9B167ACA@smtp-out1.iol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok i've tested it out. If i'll build in-kernel bttv and pass to kernel
> the parameters for the card, lirc_gpio is checked 

That looks like bug that needs fixing to me.
Late_initcall() or reordering linking should help