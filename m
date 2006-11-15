Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965797AbWKODVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965797AbWKODVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 22:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965817AbWKODVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 22:21:16 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60879
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965797AbWKODVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 22:21:16 -0500
Date: Tue, 14 Nov 2006 19:21:17 -0800 (PST)
Message-Id: <20061114.192117.112621278.davem@davemloft.net>
To: torvalds@osdl.org
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<20061114.190036.30187059.davem@davemloft.net>
	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Tue, 14 Nov 2006 19:10:42 -0800 (PST)

> Yours was still an example of "nice". And it had absolutely nothing
> to do with the _PROBLEM_.

Understood.

BTW, some drivers have taken the approch to add MSI self-tests
inside of the driver to ensure correct option of MSI on a given
machine.  There's a lot of resistence to that, the reasons for
which I grok fully, but I'm not sure other suggestions such as
black lists are any better.

Given current experience maybe white-lists are in fact the way
to go.
