Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262381AbSI2DWf>; Sat, 28 Sep 2002 23:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262382AbSI2DWf>; Sat, 28 Sep 2002 23:22:35 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:55558 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262381AbSI2DWe>; Sat, 28 Sep 2002 23:22:34 -0400
Date: Sun, 29 Sep 2002 04:27:56 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] oprofile for 2.5.39
Message-ID: <20020929032756.GA68826@compsoc.man.ac.uk>
References: <20020929014440.GA66796@compsoc.man.ac.uk.suse.lists.linux.kernel> <p737kh5sf45.fsf@oldwotan.suse.de> <20020929025224.GA68153@compsoc.man.ac.uk> <20020929050807.A17869@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929050807.A17869@wotan.suse.de>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 05:08:07AM +0200, Andi Kleen wrote:

> I think you can easily do that by keeping state per cpu in the 
> NMI handler.

You're quite right, it's simpler as well.

I had a distinct memory of not doing this because it wouldn't work
originally, but I forget what the reasoning was.

> smp_processor_id - per cpu data doesn't work from modules]

yes, which was why I don't use it already.

[Are there any advantages to per_cpu stuff over hand-coding, other
than readability ??]

thanks
john
-- 
"When your name is Winner, that's it. You don't need a nickname."
	- Loser Lane
