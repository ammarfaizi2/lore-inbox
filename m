Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWA3J4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWA3J4V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWA3J4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:56:21 -0500
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:34083 "HELO
	topsns.toshiba-tops.co.jp") by vger.kernel.org with SMTP
	id S932189AbWA3J4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:56:20 -0500
Date: Mon, 30 Jan 2006 18:56:08 +0900 (JST)
Message-Id: <20060130.185608.30186596.nemoto@toshiba-tops.co.jp>
To: tiwai@suse.de
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, tbm@cyrius.com,
       t.sailer@alumni.ethz.ch, perex@suse.cz, ralf@linux-mips.org
Subject: Re: ALSA on MIPS platform
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <s5h7j8l64ua.wl%tiwai@suse.de>
References: <Pine.LNX.4.61.0601261910230.15596@goblin.wat.veritas.com>
	<20060128.004540.59467062.anemo@mba.ocn.ne.jp>
	<s5h7j8l64ua.wl%tiwai@suse.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 27 Jan 2006 16:57:49 +0100, Takashi Iwai <tiwai@suse.de> said:
hugh> Yes, mark_pages() and unmark_pages() can just be removed as soon
hugh> as you like.

>> When I tried undefining NEED_RESERVE_PAGES for MIPS on 2.6.13,
>> something did not work (I can not remember details...).  But it seems
>> things have been changed in 2.6.15.  I'll try again.  Thanks.

tiwai> Yes, it was changed pretty much.

I undefined NEED_RESERVE_PAGES on 2.6.15 and it seems OK on MIPS.
Thank you.

---
Atsushi Nemoto
