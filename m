Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWDGXgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWDGXgp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 19:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWDGXgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 19:36:45 -0400
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:47569 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S964986AbWDGXgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 19:36:45 -0400
Message-ID: <4436AA74.6020002@drzeus.cx>
Date: Fri, 07 Apr 2006 20:07:48 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Ram <vshrirama@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: SDIO Drivers?
References: <8bf247760604040130n155eeffauc5798750f8357bca@mail.gmail.com> <443628F3.9050107@drzeus.cx> <20060407144314.GB21049@flint.arm.linux.org.uk>
In-Reply-To: <20060407144314.GB21049@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
>
> I think we would be forced to re-think the existing model - SDIO cards
> seem to be able to support simultaneously both block device and IO.
> Therefore, it would appear that we need the ability to register two
> drivers against the same device.
>
>   

On the other hand, they both need to select cards so there is some
overlap in how they grab the bus.

Also, MMC has some kind of register support as well. But I can't say
that I've ever seen anything but MMC memory cards.

Rgds
Pierre


