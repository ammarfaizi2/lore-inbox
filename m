Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265610AbUALUzK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 15:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbUALUzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 15:55:10 -0500
Received: from smtpq2.home.nl ([213.51.128.197]:15237 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S265610AbUALUzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 15:55:05 -0500
Message-ID: <400308DA.40107@keyaccess.nl>
Date: Mon, 12 Jan 2004 21:51:38 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Rene Herman <rene.herman@keyaccess.nl>,
       Santiago Garcia Mantinan <manty@manty.net>,
       linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
Subject: Re: ALSA in 2.6 failing to find the OPL chip of the sb cards
References: <20040107212916.GA978@man.manty.net>	<s5hy8sixsor.wl@alsa2.suse.de>	<20040109171715.GA933@man.manty.net>	<s5hn08xgh06.wl@alsa2.suse.de>	<20040109201423.GA1677@man.manty.net>	<3FFFA8C3.6040609@keyaccess.nl> <s5hu131b2tx.wl@alsa2.suse.de>
In-Reply-To: <s5hu131b2tx.wl@alsa2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:

[ OPl3 not in /proc/ioports for SB16/AWE ]

> it's a bug.  the attached patch should fix it.

It does:

0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)

With both patches applied, sb16 is fine again.

Rene.

