Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbTGBS36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTGBS35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:29:57 -0400
Received: from hera.cwi.nl ([192.16.191.8]:31113 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264362AbTGBS34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:29:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 2 Jul 2003 20:44:18 +0200 (MEST)
Message-Id: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@digeo.com
Subject: Re: [PATCH] cryptoloop
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm:

> You'll note that loop.c goes from (page/offset/len) to (addr/len),
> and this transfer function then immediately goes from (addr,len)
> to (page/offset/len). That's rather silly ..

Changing that would kill all existing modules that use the loop device.

Maybe nobody cares. Then we can do so in a subsequent patch.

Andries
