Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWFOMKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWFOMKx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWFOMKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:10:52 -0400
Received: from mail.gmx.de ([213.165.64.21]:4027 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030288AbWFOMKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:10:52 -0400
X-Authenticated: #14349625
Subject: Re: bad command responsiveness Proliant DL 585
From: Mike Galbraith <efault@gmx.de>
To: david@dworf.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <449141F6.3090902@dworf.com>
References: <448FC1CE.9090108@dworf.com>
	 <1150278161.7994.13.camel@Homer.TheSimpsons.net> <449060EE.60608@dworf.com>
	 <1150353862.8097.61.camel@Homer.TheSimpsons.net> <44910E5B.50704@dworf.com>
	 <1150358450.8638.12.camel@Homer.TheSimpsons.net>
	 <449141F6.3090902@dworf.com>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 14:14:32 +0200
Message-Id: <1150373673.7831.7.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-15 at 13:18 +0200, David Osojnik wrote:
> Well i tired cfq,anticipatory,deadline,no-op schedulers/elevators with
> atime but none worked the only difference is when I use noatime and
> nodiratime

That's the result I expected.

> could this be an kernel problem?

Sure seems like one to me.  Perhaps someone with a good understanding of
journaling fs will comment.  I can only speculate.

	-Mike

