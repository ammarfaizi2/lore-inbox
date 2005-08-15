Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVHOUGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVHOUGG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVHOUGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:06:05 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:1454 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964887AbVHOUGF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:06:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JMyJQh6YJWDyZdwUBrbrmfkBUkzfXyM1QtnvsNQX10pjK6BXPNHHKu01g9U6UoFoGsYNkIWBs6NlGrr6WbFmIXpghXQL5Q3yrHuq+pKFZ49+7fWac4ILgQx42ZKJp7J1AXv0jVnAXiMBnQ7G4Ms75Ivy0V1cdXAa1004u7kVvC0=
Message-ID: <161717d505081513066c660129@mail.gmail.com>
Date: Mon, 15 Aug 2005 16:06:04 -0400
From: Dave Neuer <mr.fred.smoothie@gmail.com>
Reply-To: mr.fred.smoothie@pobox.com
To: Joe Peterson <joe@skyrush.com>
Subject: Re: [PATCH] to drivers/input/evdev.c to add mixer device "/dev/input/events"
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <4300EF7C.9020500@skyrush.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4300D09C.4030702@skyrush.com> <20050815174558.GB1450@ucw.cz>
	 <4300D845.8070605@skyrush.com> <20050815185729.GA1450@ucw.cz>
	 <4300EF7C.9020500@skyrush.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/05, Joe Peterson <joe@skyrush.com> wrote:
> 
> So, overall, I agree that we should not invent hacks to make up for
> another software package's problems...

but also wrote:

> If the kernel could handle that aspect, it would make all programs more stable.

which seems a little contradictory.

However, Joe continued with:

> It does not sound right to push the handling of the intermittent nature
> to each user program.

Indeed. Each user program should not care about it. An event/hotplug
library should, and the user programs should use that. Like d-bus/HAL.

Dave
