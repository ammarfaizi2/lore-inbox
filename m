Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVC1BnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVC1BnF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 20:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVC1BnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 20:43:05 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:47450
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261652AbVC1BnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 20:43:02 -0500
Date: Mon, 28 Mar 2005 03:42:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Takashi Iwai <tiwai@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Mac mini sound woes
Message-ID: <20050328014259.GF4110@g5.random>
References: <1111966920.5409.27.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111966920.5409.27.camel@gaston>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 09:42:00AM +1000, Benjamin Herrenschmidt wrote:
> suggest I just don't do any control ? Or should I implement a double
> buffer scheme with software gain as well in the kernel driver ?

I recall to have sometime clicked on volume controls that weren't
hardware related, I don't pay much attention when stuff works, perhaps
it was the kde sound system doing it or something like that.

I would suggest doing the D->A only, then adding a basic hack to
g5 too ;), and then go back to the mini to do the gain emulation in
kernel space if somebody complains ;). Doing the software emulation
sounds quite orthogonal to the rest so it can be done later if needed.

Too loud sound is better than no sound.
