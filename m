Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVD0Pdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVD0Pdf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVD0Pd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:33:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2974 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261609AbVD0PdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:33:22 -0400
Date: Wed, 27 Apr 2005 17:33:20 +0200
From: Martin Mares <mj@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, pavel@suse.cz, hch@infradead.org, linuxram@us.ibm.com,
       7eggert@gmx.de, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050427153320.GA19065@atrey.karlin.mff.cuni.cz>
References: <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427143126.GB1957@mail.shareable.org> <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It is not there for the purpose of protecting user's data.  Rather for
> protecting other users (including root) from unknowingly entering the
> FUSE directory and thus leaking otherwise inaccessible information
> (exact file operations performed) to the mount owner.

Huh? Do you really suppose that there could be anything secret in the
operations somebody else is performing on your files?

I still don't see any real problem this check could ever solve.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
God is real, unless declared integer.
