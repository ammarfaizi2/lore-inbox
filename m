Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbUCKPW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbUCKPWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:22:17 -0500
Received: from colin2.muc.de ([193.149.48.15]:781 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261410AbUCKPU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:20:26 -0500
Date: 11 Mar 2004 16:20:25 +0100
Date: Thu, 11 Mar 2004 16:20:25 +0100
From: Andi Kleen <ak@muc.de>
To: Mickael Marchand <marchand@kde.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, dm@uk.sistina.com
Subject: Re: 2.6.4-mm1
Message-ID: <20040311152025.GB22284@colin2.muc.de>
References: <1ysXv-wm-11@gated-at.bofh.it> <200403111445.35075.marchand@kde.org> <20040311144829.GA22284@colin2.muc.de> <200403111610.02128.marchand@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403111610.02128.marchand@kde.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 04:10:02PM +0100, Mickael Marchand wrote:
> just the ioctl cmd failed I reported in my first mail.
> then dmsetup just stops...

Either it doesn't handle the fallback correctly or the ioctls 
are not compatible.

>From a quick look at dm-ioctl.h I found some suspicious cases,
but no clear failures.

-Andi
