Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVB1Q45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVB1Q45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVB1Q4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:56:02 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:51078 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261690AbVB1QzH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:55:07 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 28 Feb 2005 17:52:19 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: James Bruce <bruce@andrew.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
Message-ID: <20050228165219.GA25892@bytesex>
References: <422001CD.7020806@andrew.cmu.edu> <20050228134410.GA7499@bytesex> <42232DFC.6090000@andrew.cmu.edu> <87mzto3c78.fsf@bytesex.org> <20050228164459.GI21514@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228164459.GI21514@vanheusden.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I remember something about that you shouldn't use the teletext-decoder
> at the same time as viewing regular tv. That would damage the eeprom.
> Maybe it is related?

No.  Thats (a) very old and about two drivers banging on the bt848 card
at the same time, where the second doesn't even exist for 2.4 any more I
think.  And (b) damage in that case means "write random bytes to it",
which is a very different issue.  You can still read it in that case.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
