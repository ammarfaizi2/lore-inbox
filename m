Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317878AbSGaJzX>; Wed, 31 Jul 2002 05:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317889AbSGaJzX>; Wed, 31 Jul 2002 05:55:23 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:60383 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317878AbSGaJzW>;
	Wed, 31 Jul 2002 05:55:22 -0400
Date: Wed, 31 Jul 2002 11:58:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Fix suspend of the kseriod thread
Message-ID: <20020731115818.A26329@ucw.cz>
References: <20020730225736.K7677@flint.arm.linux.org.uk> <20020730122638.A11153@ucw.cz> <20020730122918.A11248@ucw.cz> <20020730152255.A20071@ucw.cz> <20020730152342.B20071@ucw.cz> <20020730221722.A22761@ucw.cz> <20020730225736.K7677@flint.arm.linux.org.uk> <9658.1028109354@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9658.1028109354@redhat.com>; from dwmw2@infradead.org on Wed, Jul 31, 2002 at 10:55:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 10:55:54AM +0100, David Woodhouse wrote:

> rmk@arm.linux.org.uk said:
> >  Isn't interruptible_sleep_on() taboo? 
> 
> With the demise of cli() and the continued removal of the BKL, all users of 
> sleep_on() are probably buggy. We should remove it completely.

Ok. Is the use in drivers/input/serio.c buggy?
What should be it replaced with?

-- 
Vojtech Pavlik
SuSE Labs
