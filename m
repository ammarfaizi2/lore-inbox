Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWC0Sws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWC0Sws (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 13:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWC0Sws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 13:52:48 -0500
Received: from [212.76.81.25] ([212.76.81.25]:7436 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750833AbWC0Swr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 13:52:47 -0500
From: Al Boldi <a1426z@gawab.com>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: scheduler starvation resistance patches for 2.6.16
Date: Mon, 27 Mar 2006 21:36:07 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200603272136.07908.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> Knowing that not everybody runs the latest/greatest mm kernels, I've
> adapted my scheduler starvation resistance tree to virgin 2.6.16.

Thanks! 

> Test feedback much appreciated.

It's not bad.  w/ credit_c1/2 set to 0 results in an improvement in running 
the MESA demos  "# gears & reflect & morph3d" .

But a simple "# while :; do :; done &" (10x) makes a "# ping 10.1 -A -s8" 
choke.

Can you post a modified patch that will apply to 2.6.16-rt10 as well?

Thanks!

--
Al

