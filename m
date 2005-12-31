Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVLaFgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVLaFgi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 00:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbVLaFgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 00:36:38 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:17388 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751138AbVLaFgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 00:36:38 -0500
Date: Sat, 31 Dec 2005 06:36:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
In-Reply-To: <1135884385.6804.0.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0512310635360.18451@yvahk01.tjqt.qr>
References: <200512291901.jBTJ1rOm017519@laptop11.inf.utfsm.cl>
 <1135884385.6804.0.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >   - Someone asked for the kernel's i2c infrastructure to be used,but
>> >     our i2c usage is very specialised, and it would be more of a mess
>> >     to use the kernel's
>> 
>> Problem with that is that if everybody and Aunt Tillie does the same,
>> the kernel as a whole gets to be a mess. 
>
>ALSA does the exact same thing for the exact same reason.  Maybe an
>indication that the kernel's i2c layer is too heavy?

Sounds like a discussion a while back why jfs/xfs/reiser3/reiser4 all have 
their own journalling - compared to ext3-jbd.


Jan Engelhardt
-- 
