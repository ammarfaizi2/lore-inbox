Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbVLETKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVLETKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVLETKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:10:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33755 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932508AbVLETKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:10:14 -0500
Date: Mon, 5 Dec 2005 19:10:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jiri Benc <jbenc@suse.cz>
Cc: Joseph Jezak <josejx@gentoo.org>, mbuesch@freenet.de,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051205191008.GA28433@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jiri Benc <jbenc@suse.cz>, Joseph Jezak <josejx@gentoo.org>,
	mbuesch@freenet.de, linux-kernel@vger.kernel.org,
	bcm43xx-dev@lists.berlios.de, NetDev <netdev@vger.kernel.org>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205190038.04b7b7c1@griffin.suse.cz> <4394892D.2090100@gentoo.org> <20051205195543.5a2e2a8d@griffin.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205195543.5a2e2a8d@griffin.suse.cz>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 07:55:43PM +0100, Jiri Benc wrote:
> Unfortunately, the only long-term solution is to rewrite completely the
> current in-kernel ieee80211 code (I would not call it a "stack") or
> replace it with something another. The current code was written for
> Intel devices and it doesn't support anything else - so every developer
> of a wifi driver tries to implement his own "softmac" now. I cannot see
> how this can move as forward and I think we can agree this is not the
> way to go.

Please stop beeing a freaking jackass.  There are various projects using
the current code.  It's not perfect but people are working on it.  And Joseph &
friends are writing a module to support softmac cards in that framework,
which is one of the most urgently needed things right now, because all the
existing softmac frameworks don't work with that code.

And please stop your stupid devicespace advertisements.  If you think the
code is so useful why don't you send patches to integrate it with the
currently existing wireless code (after cleaning up the horrible mess
it is currently)?
