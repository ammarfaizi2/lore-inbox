Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWEJJk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWEJJk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 05:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWEJJk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 05:40:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63907 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964879AbWEJJk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 05:40:27 -0400
Date: Wed, 10 May 2006 11:39:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, trenn@suse.de,
       thoenig@suse.de
Subject: Re: [RFC] [PATCH] Execute PCI quirks on resume from suspend-to-RAM
Message-ID: <20060510093942.GA12259@elf.ucw.cz>
References: <446139FF.205@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446139FF.205@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> machines with the asus_hides_smbus "feature" have the problem
> that the smbus is disabled again after suspend-to-RAM. This
> causes all sorts of problems, the worst being a total fan
> failure on my Samsung P35 notebook after STR and STD.

What happens if we disable hiding altogether? ASUS decided software
should not see smbus, perhaps they had a reason?

If we decide that we want to keep unhiding, redoing quirks after
resume is probably neccessary...
							Pavel


> References: Novell bugzilla #173420.
> 
> This (totally ugly) patch fixes it.
> Comments/criticism welcome.
> 
> Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
