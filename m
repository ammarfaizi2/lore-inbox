Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVD0Qqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVD0Qqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 12:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVD0Qqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 12:46:55 -0400
Received: from albireo.ucw.cz ([84.242.65.67]:44161 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261798AbVD0Qqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 12:46:51 -0400
Date: Wed, 27 Apr 2005 18:46:52 +0200
From: Martin Mares <mj@ucw.cz>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050427164652.GA3129@ucw.cz>
References: <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427143126.GB1957@mail.shareable.org> <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu> <20050427153320.GA19065@atrey.karlin.mff.cuni.cz> <20050427155022.GR4431@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427155022.GR4431@marowsky-bree.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It is certainly an information leak not otherwise available. And with
> the ability to change the layout underneath, you might trigger bugs in
> root programs: Are they really capable of seeing the same filename
> twice, or can you throw them into a deep recursion by simulating
> infinitely deep directories/circular hardlinks...?

Yes, it can help you trigger bugs, but all these bugs are triggerable
without user filesystems as well, although it's harder to do so.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
If the government wants us to respect the law, it should set a better example.
