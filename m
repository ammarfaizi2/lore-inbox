Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVCNRLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVCNRLX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVCNRLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:11:22 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46225 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261629AbVCNRLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:11:13 -0500
Date: Mon, 14 Mar 2005 18:10:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux-os <linux-os@analogic.com>
Cc: Jakob Eriksson <jakov@vmlinux.org>, Andi Kleen <ak@muc.de>,
       Stas Sergeev <stsp@aknet.ru>, Alan Cox <alan@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       wine-devel@winehq.org, torvalds@osdl.org
Subject: Re: [patch] x86: fix ESP corruption CPU bug
Message-ID: <20050314171052.GD5461@elf.ucw.cz>
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz> <4234A8DD.9080305@aknet.ru> <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org> <Pine.LNX.4.58.0503131614360.2822@ppc970.osdl.org> <423518A7.9030704@aknet.ru> <m14qfey3iz.fsf@muc.de> <4235AC0B.70507@vmlinux.org> <Pine.LNX.4.61.0503141158460.19270@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503141158460.19270@chaos.analogic.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Can you tell me how the invisible high-word (invisible in VM-86, and
> in real mode) could possibly harm something running in VM-86 or
> read-mode ???  I don't even think it's a BUG. If the transition

You can have protected-mode application running in dosemu with 16-bit
stack segment.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
