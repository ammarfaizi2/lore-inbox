Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbWHNUH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWHNUH4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 16:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbWHNUH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 16:07:56 -0400
Received: from main.gmane.org ([80.91.229.2]:32737 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932690AbWHNUHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 16:07:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Polling for battery stauts and lost keypresses (was: Touchpad problems with latest kernels)
Date: Mon, 14 Aug 2006 22:06:16 +0200
Message-ID: <1q38ghnxvrliv$.zzgutgu0exkm$.dlg@40tude.net>
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl> <200608141038.04746.gene.heskett@verizon.net> <20060814152000.GA19065@rhlx01.fht-esslingen.de> <d120d5000608140841q657c6c2euae986b37f6aff605@mail.gmail.com> <20060814155437.GA801@rhlx01.fht-esslingen.de> <d120d5000608140906x47bc572blb1b9821ead987d7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-220-198-158.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 12:06:06 -0400, Dmitry Torokhov wrote:

> On many laptops (including mine) polling battery takes a loooong time
> and is done in SMI mode in BIOS causing lost keypresses, jerky mouse
> etc. It is pretty common problem. I think I have my ACPI client
> refreshing every 3 minutes.

BTW, polling battery status takes a lot on a Dell Inspiron 8200 too,
and all keypresses and mouse movements (and I think even network
IRQs?) are totally *dead* while polling.

However, The Other OS(tm) *seems* to do it right enough to have no
noticeable keypress losses, even when updating the battery status. Is
it using different system calls, or what?

-- 
Giuseppe "Oblomov" Bilotta

[W]hat country can preserve its liberties, if its rulers are not
warned from time to time that [the] people preserve the spirit of
resistance? Let them take arms...The tree of liberty must be
refreshed from time to time, with the blood of patriots and
tyrants.
	-- Thomas Jefferson, letter to Col. William S. Smith, 1787

