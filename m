Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVAHNHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVAHNHh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVAHNHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:07:37 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:655 "EHLO hibernia.jakma.org")
	by vger.kernel.org with ESMTP id S261154AbVAHNHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:07:21 -0500
Date: Sat, 8 Jan 2005 13:04:25 +0000 (UTC)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: Paul Davis <paul@linuxaudiosystems.com>
cc: Martin Mares <mj@ucw.cz>, Arjan van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-Reply-To: <200501071622.j07GMUCr018735@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0501081300450.11238@sheen.jakma.org>
References: <200501071622.j07GMUCr018735@localhost.localdomain>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005, Paul Davis wrote:

> capabilities work - we use them in 2.4 where a helper suid application
> gets the ball rolling, and then its child grants capabilities to new
> clients.

We use them too in Quagga. Reasonably happy with them.

Not a panacae, but far better to retain just a few capabilities, than 
retaining ruid 0 (as we must on other systems).

Only issue really is "graininess" of capabilities, which i'd guess is 
a double-edged sword.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Kill Ugly Radio
- Frank Zappa
