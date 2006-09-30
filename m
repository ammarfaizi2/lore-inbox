Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751922AbWI3UvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbWI3UvY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWI3UvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:51:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48770 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751922AbWI3UvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:51:23 -0400
Date: Sat, 30 Sep 2006 22:51:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       ext-Tuukka.Tikkanen@nokia.com
Subject: Re: [linux-pm] PowerOP, Whatchanged/Issues/TODO 2/2
Message-ID: <20060930205115.GA3061@elf.ucw.cz>
References: <20060930014412.98405be8.eugeny.mints@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060930014412.98405be8.eugeny.mints@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-09-30 01:44:12, Eugeny S. Mints wrote:
> whatchanged:
> - new concept of powerop power parameter is introduced
> - new powerop core interface routine to set individual(or subset of)
>   power parameter value is added
> - no more string parsing at any layer
> - no more va_list interface 
> - powerop driver module refcounting is added
> - documentation file including optional sysfs interface description is added
> 
> todo/issues:
> - better implementation for getting registered operating point names
> - configfs for operating points creation from user space

You forgot to mention: how to solve the "256 cpus, 2 power states
each" case?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
