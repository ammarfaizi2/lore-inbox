Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWH3Xqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWH3Xqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWH3Xqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:46:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63657 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750777AbWH3Xqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:46:53 -0400
Date: Thu, 31 Aug 2006 01:46:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mimi Zohar <zohar@us.ibm.com>
Cc: Crispin Cowan <crispin@novell.com>, David Safford <safford@us.ibm.com>,
       kjhall@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       linux-security-module-owner@vger.kernel.org,
       David Safford <safford@watson.ibm.com>,
       Serge E Hallyn <sergeh@us.ibm.com>
Subject: Re: [RFC][PATCH 8/8] SLIM: documentation
Message-ID: <20060830234627.GM3923@elf.ucw.cz>
References: <20060830225950.GI3923@elf.ucw.cz> <OF47A7AF49.EC4403C3-ON852571DA.00818B73-852571DA.006C6E56@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF47A7AF49.EC4403C3-ON852571DA.00818B73-852571DA.006C6E56@us.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > But my ssh data can't be classified higher, because ssh interacts with
> > network. Ouch.
> >
> > You are right that this will make recovery from spyware attack easier,
> > but...
> 
> Here you are raising concerns over secrecy, which is a totally separate
> issue from integrity.  In order to protect the secrecy of files, you
> would distinguish PUBLIC files from USER-SENSITIVE/SYSTEM-SENSITIVE
> files.

So... will I be able to set ~/.ssh/private_key to USER-SENSITIVE and
still use ssh to log in to remove machines? Will trojans coming from
network be able to read that file?

I do not think see how that can work... because ssh accesses network,
and needs to know my private_key.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
