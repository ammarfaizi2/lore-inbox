Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268786AbUIQOQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268786AbUIQOQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 10:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268776AbUIQOQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 10:16:48 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:23328 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S268791AbUIQOKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:10:49 -0400
Message-ID: <414AF06F.3090603@hotmail.com>
Date: Fri, 17 Sep 2004 07:10:55 -0700
From: walt <wa1ter@hotmail.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040916
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc2-bk] Freeze during boot (kernel panic)
References: <fa.fufkpc9.15ki31p@ifi.uio.no>
In-Reply-To: <fa.fufkpc9.15ki31p@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt wrote:
> Something committed in the last 24 hours is causing my machine
> to halt partway thru bootup...

I compiled everything into the kernel and now I can see that the
problem is a kernel panic caused by ifconfig while configuring
the loopback interface (not the ethernet chip, which is a tg3).

I'll copy and post the traceback when I get home from work.
