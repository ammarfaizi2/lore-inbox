Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319745AbSIMSfM>; Fri, 13 Sep 2002 14:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319748AbSIMSfM>; Fri, 13 Sep 2002 14:35:12 -0400
Received: from [195.39.17.254] ([195.39.17.254]:10880 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319745AbSIMSfL>;
	Fri, 13 Sep 2002 14:35:11 -0400
Date: Fri, 13 Sep 2002 19:03:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Remco Post <r.post@sara.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: writing OOPS/panic info to nvram?
Message-ID: <20020913170347.GA7096@elf.ucw.cz>
References: <20020906100650.D35@toy.ucw.cz> <4DE1BD2E-C4CD-11D6-9C2C-000393911DE2@sara.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DE1BD2E-C4CD-11D6-9C2C-000393911DE2@sara.nl>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>driver oopses... Maybe do something like:
> >>
> >>if there is enough space on disk && ..., use that else
> >>if there is a swap over nfs && ..., use that else
> >>if there is a tape drive attaced and a tape is present and it is
> >>writeable... else
> >>if there is nvram available use that
> >
> >You just killed any data you had on the tape... too bad.
> >								Pavel
> 
> Yes, so, or you just saved that oops that has been bugging you for 
> months... (And yes I'm probably one of those rare people that has 
> tapedrives attached that are not used for anything usefull).

If it was bugging you for months, then you'd have probably copied it
using paper and pencil already. cli(); while(1); at the end of oops
handler is not *that* hard to do.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
