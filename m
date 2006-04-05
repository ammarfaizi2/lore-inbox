Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWDEN4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWDEN4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 09:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWDEN4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 09:56:39 -0400
Received: from smtp1.home.se ([212.78.199.21]:21394 "EHLO smtp1.home.se")
	by vger.kernel.org with ESMTP id S1750708AbWDEN4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 09:56:39 -0400
Date: Wed, 5 Apr 2006 15:54:42 +0200
From: Martin Samuelsson <sam@home.se>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: bunk@stusta.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org
Subject: Re: [-mm patch] drivers/media/video/bt866.c: small fixes
Message-Id: <20060405155442.66d76b90.sam@home.se>
In-Reply-To: <20060405083204.GA5058@linuxtv.org>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060404163001.GO6529@stusta.de>
	<20060404203219.40fe6b4c.sam@home.se>
	<20060405083204.GA5058@linuxtv.org>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2006 10:32:04 +0200
Johannes Stezenbach <js@linuxtv.org> wrote:

> On Tue, Apr 04, 2006, Martin Samuelsson wrote:
> >  		current->state = TASK_INTERRUPTIBLE;
> > -		schedule_timeout(HZ/10);
> > +		schedule_timeout_interruptible(HZ/10);
> 
> schedule_timeout_interruptible() already sets current->state.

I have much to learn, it seems. I'll trim that off, too. Thanks!

Regards,
/Sam
