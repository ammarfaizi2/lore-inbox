Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVASATc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVASATc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVASATc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:19:32 -0500
Received: from sasami.anime.net ([207.109.251.120]:27602 "EHLO
	sasami.anime.net") by vger.kernel.org with ESMTP id S261504AbVASATU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:19:20 -0500
X-Antispam-Origin-Id: c4dc35da7d5d290438c6d6bdb17308d1
Date: Tue, 18 Jan 2005 16:18:59 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Venkat Manakkal <venkat@rayservers.com>
cc: Andries Brouwer <aebr@win.tue.nl>,
       Jari Ruusu <jariruusu@users.sourceforge.net>,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Paul Walker <paul@black-sun.demon.co.uk>,
       <linux-kernel@vger.kernel.org>, Bill Davidsen <davidsen@tmr.com>,
       <linux-crypto@nl.linux.org>, James Morris <jmorris@redhat.com>
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
In-Reply-To: <41ED57BB.7080504@rayservers.com>
Message-ID: <Pine.LNX.4.44.0501181616090.15507-100000@sasami.anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Message not sent from an IPv4 address, not delayed by milter-greylist-1.3.8 (sasami.anime.net [0.0.0.0]); Tue, 18 Jan 2005 16:19:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005, Venkat Manakkal wrote:
> As for cryptoloop, I'm sorry, I cannot say the same. The password hashing
> system being changed in the past year, poor stability and machine lockups are
> what I have noticed, besides there is nothing like the readme here:

cryptoloop is also unusably slow, even on my x86_64 machines...

at the very least someone should merge in the assembler loop-aes routines. 
all other architectural arguments/whining aside, is there any good reason 
not to do this?

-Dan

