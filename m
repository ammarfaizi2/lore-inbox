Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVFQAFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVFQAFf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 20:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVFQAFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 20:05:34 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:28804 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261862AbVFQAF3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 20:05:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IWW1RseJkgTaH60APvrVEpAA/Y18jthKK2IP46478d3vstENBTwJr7D39zW4X/cDnk0HgRCSIPq+4rRaTFFkqLTAOlEEIhHCafjlguhi8Ddxzj0QFa6Gb9ouwj7otGL0BnIVBp4ujK8nCfYtOwcOJL3W4SI7+4Vjk7KreAMSX2s=
Message-ID: <4ad99e0505061617052f427ed6@mail.gmail.com>
Date: Fri, 17 Jun 2005 02:05:28 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Christian Kujau <evil@g-house.de>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42B21130.4000608@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ad99e0505061605452e663a1e@mail.gmail.com>
	 <42B1F5CB.9020308@g-house.de>
	 <4ad99e0505061615143cc34192@mail.gmail.com>
	 <42B21130.4000608@g-house.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/05, Christian Kujau <evil@g-house.de> wrote:
> Lars Roland schrieb:
> > It does not seams to be limited to braodcom cards. 3com and Intel e100
> > cards does the exact same stunt on kernels never than 2.6.8.1. Intel
> > e1000 and realtek 8139 cards do however work.
> 
> hm - tricky, i think. because no kernel oopses, nothing to look at in the
> syslog (yes?),

Nothing anywhere, even tcpdump just seams to get cut off - I have not
been debugging ethernet drivers for years, getting a little rusty at
that, so nothing there yet.

> various nic drivers affected, others not...in cases like
> these only Documentation/BUG-HUNTING comes to my mind: if 2.6.8.1 works,
> and 2.6.12-rc6 does not, we'll need to find out the kernelversion which
> introduced this behaviour.

That I can give you, kernel 2.6.8.1 works but 2.6.9 does not (at least
not with tg3 and tulip cards).


Regards.

Lars Roland
