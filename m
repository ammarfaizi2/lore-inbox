Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUGETyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUGETyA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 15:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUGETyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 15:54:00 -0400
Received: from pra69-d108.gd.dial-up.cz ([193.85.69.108]:64128 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S261347AbUGETx7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 15:53:59 -0400
Date: Mon, 5 Jul 2004 21:53:01 +0200
To: Timothy Miller <theosib@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HELP:  Cannot get ALSA working on via82xx
Message-ID: <20040705195301.GB23211@penguin.localdomain>
Mail-Followup-To: Timothy Miller <theosib@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <BAY1-F133LSW50Pfs56000059d7@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY1-F133LSW50Pfs56000059d7@hotmail.com>
User-Agent: Mutt/1.5.6+20040523i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 12:06:26AM -0400, Timothy Miller wrote:
> Right now, the state is that regular digital audio works, but MIDI refuses 
> to work, and some other audio channel is on which produces random clicks 
> and other such noise.
> 
I wasn't able to get MIDI working too, I guess that these onboard sound
cards doesn't have support for it (but I really don't know).

The random noise could be caused by wrong mixer setting. Try save mixer
settings when you are using OSS, and restore them while running ALSA
(you can use oss-preserve for it).

-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

