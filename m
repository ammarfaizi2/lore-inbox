Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266962AbUBRApq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUBRAmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:42:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:6052 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266962AbUBRAka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:40:30 -0500
Subject: Re: Linux 2.6.3-rc4 Massive strange corruption with new radeonfb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Charles Johnston <cjohnston@networld.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4032B084.5020405@networld.com>
References: <403274D2.4020407@networld.com>
	 <1077055997.1076.23.camel@gaston>  <40329B57.9060901@networld.com>
	 <1077060699.1078.38.camel@gaston>  <4032B084.5020405@networld.com>
Content-Type: text/plain
Message-Id: <1077064587.1081.78.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 11:36:27 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Yes, the blanking issue is still present without XFree.

Ok, that would be the fillrect() operation not working properly.

I'll look at it.

Ben.


