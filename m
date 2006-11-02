Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752365AbWKBT0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbWKBT0O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbWKBT0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:26:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:39082 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752362AbWKBT0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:26:14 -0500
Date: Thu, 2 Nov 2006 11:26:07 -0800
From: Greg KH <greg@kroah.com>
To: Damien Wyart <damien.wyart@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       James@superbug.demon.co.uk, Takashi Iwai <tiwai@suse.de>
Subject: Re: ALSA message with 2.6.19-rc4-mm2 (not -mm1)
Message-ID: <20061102192607.GA13635@kroah.com>
References: <20061102102607.GA2176@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102102607.GA2176@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 11:26:07AM +0100, Damien Wyart wrote:
> Hello,
> 
> I notice these messages when 2.6.19-rc4-mm2 boots (also with rc3-mm1)
> but 2.6.19-rc4-mm1 did NOT display them. Related to the driver tree ?
> Full dmesg and lspci attached. Can provide more details if needed.

How many different sound cards do you have in your machine?

Can you send me the output of 'ls /sys/class/sound/' with the 2.6.19-rc4
(or any other non-mm) kernel?

And yes, I'd blame this one on ALSA, but I want to make sure I didn't do
anything foolish here too :)

thanks,

greg k-h
