Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVLETbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVLETbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbVLETbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:31:24 -0500
Received: from styx.suse.cz ([82.119.242.94]:54737 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751396AbVLETbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:31:23 -0500
Date: Mon, 5 Dec 2005 20:31:21 +0100
From: Jiri Benc <jbenc@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joseph Jezak <josejx@gentoo.org>, mbuesch@freenet.de,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051205203121.48241a08@griffin.suse.cz>
In-Reply-To: <20051205191008.GA28433@infradead.org>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	<20051205190038.04b7b7c1@griffin.suse.cz>
	<4394892D.2090100@gentoo.org>
	<20051205195543.5a2e2a8d@griffin.suse.cz>
	<20051205191008.GA28433@infradead.org>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2005 19:10:08 +0000, Christoph Hellwig wrote:
> Please stop beeing a freaking jackass.  There are various projects using
> the current code.  It's not perfect but people are working on it.

Yes, and everyone implements his own softmac (this is the third one I
know about). I tried to put all of these efforts together (google
through the netdev archives) and wrote many patches.

> And Joseph &
> friends are writing a module to support softmac cards in that framework,
> which is one of the most urgently needed things right now, because all the
> existing softmac frameworks don't work with that code.

And authors of rtl8180 did it too. And authors of adm8211 too.

> And please stop your stupid devicespace advertisements.  If you think the
> code is so useful why don't you send patches to integrate it with the
> currently existing wireless code (after cleaning up the horrible mess
> it is currently)?

This is what I'm doing last two months. But it's not so easy to clean it
up and it seems that nobody else is interested. But it has all of the
features you need (except active scanning) - this is the reason I
stopped to work on improving current in-kernel 802.11 code and focused
on Devicescape's code. It is several years beyond the state that current
code is at now. And it is not an advertisement, it is a fact.


-- 
Jiri Benc
SUSE Labs
