Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319393AbSIFUxn>; Fri, 6 Sep 2002 16:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319395AbSIFUx0>; Fri, 6 Sep 2002 16:53:26 -0400
Received: from [195.39.17.254] ([195.39.17.254]:11136 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319393AbSIFUwP>;
	Fri, 6 Sep 2002 16:52:15 -0400
Date: Fri, 6 Sep 2002 10:06:51 +0000
From: Pavel Machek <pavel@suse.cz>
To: Remco Post <r.post@sara.nl>
Cc: "J.A. Magallon" <jamagallon@able.es>, morten.helgesen@nextframe.net,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: writing OOPS/panic info to nvram?
Message-ID: <20020906100650.D35@toy.ucw.cz>
References: <20020904140856.GA1949@werewolf.able.es> <D365BFFC-C011-11D6-A20D-000393911DE2@sara.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <D365BFFC-C011-11D6-A20D-000393911DE2@sara.nl>; from r.post@sara.nl on Wed, Sep 04, 2002 at 04:23:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> driver oopses... Maybe do something like:
> 
> if there is enough space on disk && ..., use that else
> if there is a swap over nfs && ..., use that else
> if there is a tape drive attaced and a tape is present and it is 
> writeable... else
> if there is nvram available use that

You just killed any data you had on the tape... too bad.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

