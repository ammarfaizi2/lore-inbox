Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752147AbWCFHwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbWCFHwx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbWCFHwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:52:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29659 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752147AbWCFHww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:52:52 -0500
Subject: Re: Is that an acceptable interface change?
From: Arjan van de Ven <arjan@infradead.org>
To: Olivier Galibert <galibert@pobox.com>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>
In-Reply-To: <20060306011757.GA21649@dspnet.fr.eu.org>
References: <20060306011757.GA21649@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 08:52:48 +0100
Message-Id: <1141631568.4084.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 02:17 +0100, Olivier Galibert wrote:
> I'm looking at the changes in the asound.h file, and especially at
> commit 512bbd6a85230f16389f0dd51925472e72fc8a91, and I've been
> wondering if it's acceptable compatibility-wise.  All the structures
> passed through ioctl (and ALSA is 100% ioctl) have been renamed from
> sndrv_* to snd_*.  That breaks source compatibility but not binary
> compatibility.

only if you are "stupid" enough to use kernel headers in your userspace!
Which you shouldn't do normally

