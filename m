Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWAaP5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWAaP5U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWAaP5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:57:19 -0500
Received: from [212.76.85.204] ([212.76.85.204]:27140 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750777AbWAaP5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:57:18 -0500
From: Al Boldi <a1426z@gawab.com>
To: devzero@web.de
Subject: Re: [PATCH 2.6.15-git9a] aoe [1/1]: do not stop retransmit timer when device goes down
Date: Tue, 31 Jan 2006 18:56:04 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       "Ed L. Cashin" <ecashin@coraid.com>
References: <972671705@web.de>
In-Reply-To: <972671705@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601311856.04271.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devzero@web.de wrote:
> Hello!
>
> >Why is the userland vblade server slower than the userland nbd-server?
>
> maybe it yet is`t optimized for speed !?
> nbd probably is more mature, too.
>
> as of writing this, maybe the userspace vblade is meant for
> demonstration/testing/learning purpose. you wouldn`t buy a etherblade from
> coraid just for testing AoE - would you?

It's running on layer-2, it should be faster no matter what.
If it's not faster, it would indicate some underlying problem.

Also, is there an nbd-server/client running over udp?

Thanks!

--
Al

