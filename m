Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752737AbVHGVAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbVHGVAy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 17:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbVHGVAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 17:00:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50626 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752737AbVHGVAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 17:00:53 -0400
Date: Sun, 7 Aug 2005 14:00:38 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Maurer <martinmaurer@gmx.at>
Cc: stern@rowland.harvard.edu, martin.maurer@email.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Re: Fw: Re: Elitegroup K7S5A + usb_storage problem
Message-Id: <20050807140038.29e3d4e3.zaitcev@redhat.com>
In-Reply-To: <200508072247.43916.martinmaurer@gmx.at>
References: <Pine.LNX.4.44L0.0508071400290.32668-100000@netrider.rowland.org>
	<200508072247.43916.martinmaurer@gmx.at>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Aug 2005 22:47:40 +0200, Martin Maurer <martinmaurer@gmx.at> wrote:

> > Just out of curiosity, if you plug the player into a Windows system
> > without installing any special drivers first, will Windows be able to read
> > and write files okay?  If it can, a USB packet trace may give Pete a clue
> > as to where to look.

> as far as i recall i didnt install any special drivers for my win 2k and win 
> xp systems. (i got this mp3 player quite a while now...)
> How would I do such an packet trace ?

I have never run Snoopy on Windows myself and I did not want to subject
you to it. Let's try my delay patch first. If that fails, I guess we
have to get instructions from someone who knows how to run Snoopy.
Maybe Windows issues some cache synchronization command when it
commits FAT. Then the packet trace should show it.

-- Pete
