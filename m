Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130309AbRAXSvA>; Wed, 24 Jan 2001 13:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131784AbRAXSuw>; Wed, 24 Jan 2001 13:50:52 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:58611 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S131368AbRAXSuj>; Wed, 24 Jan 2001 13:50:39 -0500
Date: Wed, 24 Jan 2001 12:50:38 -0600
From: Timur Tabi <ttabi@interactivesi.com>
Cc: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
        Linux MM mailing list <linux-mm@kvack.org>
In-Reply-To: <3A6F22D7.3000709@valinux.com>
In-Reply-To: <20010124174824Z129401-18594+948@vger.kernel.org>
Subject: Re: Page Attribute Table (PAT) support?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010124185046Z131368-18595+642@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Jeff Hartmann <jhartmann@valinux.com> on Wed, 24 Jan
2001 11:45:43 -0700


> I'm actually writing support for the PAT as we speak.  I already have 
> working code for PAT setup.  Just having a parameter for ioremap is not 
> enough, unfortunately.  According to the Intel Architecture Software 
> Developer's Manual we have to remove all mappings of the page that are 
> cached.  Only then can they be mapped with per page write combining.  I 
> should have working code by the 2.5.x timeframe.  I can also discuss the 
> planned interface if anyone is interested.

I'm interested.  Would it be possible to port this support to 2.2, or would
that be too much work?


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
