Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267813AbUHJXPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267813AbUHJXPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267814AbUHJXPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:15:10 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:59805 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S267813AbUHJXPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:15:04 -0400
Date: Wed, 11 Aug 2004 00:14:54 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: "Luesley, William" <william.luesley@amsjv.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Network routing issue
In-Reply-To: <22CE8E75BE6AD3119A9800508B0FF7E9030BADD7@nmex02.nm.dsx.bae.co.uk>
Message-ID: <Pine.LNX.4.60.0408110013070.2622@fogarty.jakma.org>
References: <22CE8E75BE6AD3119A9800508B0FF7E9030BADD7@nmex02.nm.dsx.bae.co.uk>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Luesley, William wrote:

> My problem is I need to modify the messages before passing them on. 
> As far as I'm aware, bridges don't do that - but then I'm a newbie 
> when it comes to bridging!

Well, I'm not sure what ebtables can do.

If you can modify the routes on A and B (ie route A via C on B, B via 
C on A), then you can use iptables to modify the packet in various 
ways, or even DNAT to redirect the packets to a local port.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Si jeunesse savait, si vieillesse pouvait.
 	[If youth but knew, if old age but could.]
 		-- Henri Estienne
