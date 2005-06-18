Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVFRWjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVFRWjr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 18:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVFRWjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 18:39:46 -0400
Received: from tim.rpsys.net ([194.106.48.114]:47018 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262177AbVFRWja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 18:39:30 -0400
Subject: Re: 2.6.12-rc6-mm1
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <linux@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050607042931.23f8f8e0.akpm@osdl.org>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 18 Jun 2005 23:39:18 +0100
Message-Id: <1119134359.7675.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 04:29 -0700, Andrew Morton wrote:
> +git-arm-smp.patch
> 
>  ARM git trees

The arm pxa255 based Zaurus won't resume from a suspend with the patches
from the above tree applied. The suspend looks normal and gets at least
as far as pxa_pm_enter(). After that, the device appears to be dead and
needs a battery removal to reset. I'm unsure if it actually suspends and
is failing to resume or is crashing in the latter suspend stages.

Is there some documentation on what the above patch is aiming to do
anywhere?

Richard



