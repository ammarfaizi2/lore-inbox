Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbTBOS66>; Sat, 15 Feb 2003 13:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbTBOS66>; Sat, 15 Feb 2003 13:58:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44815 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264886AbTBOS64>;
	Sat, 15 Feb 2003 13:58:56 -0500
Message-ID: <3E4E9028.3090601@pobox.com>
Date: Sat, 15 Feb 2003 14:08:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [0/4][via-rhine] Improvements
References: <20030215111705.GA11127@k3.hellgate.ch>
In-Reply-To: <20030215111705.GA11127@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
> Here comes a batch of patches for the via-rhine driver. Please apply.
> 
> via-rhine is still hardly usable on the most common Rhine hardware; it
> can't sustain 100Mbps traffic. The changes presented here improve the
> situation considerably; they fix a number of real problems and have been
> tested for regression (alas, by few people).


Looks good, all patches applied to 2.5.

Should these apply to 2.4, too?

Just a general comment, the reset logic seems a bit too much like voodoo 
magic ;-)  It would be nice long-term to get an official answer from Via 
about the proper reset sequence and time limits.  [regardless, like I 
said, patch applied...]

	Jeff



