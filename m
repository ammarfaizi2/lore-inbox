Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319842AbSINBDq>; Fri, 13 Sep 2002 21:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319843AbSINBDq>; Fri, 13 Sep 2002 21:03:46 -0400
Received: from web40512.mail.yahoo.com ([66.218.78.129]:38977 "HELO
	web40512.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S319842AbSINBDq>; Fri, 13 Sep 2002 21:03:46 -0400
Message-ID: <20020914010834.73118.qmail@web40512.mail.yahoo.com>
Date: Fri, 13 Sep 2002 18:08:34 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: Possible bug and question about ide_notify_reboot in drivers/ide/ide.c (2.4.19)
To: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10209131035230.29877-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Andre Hedrick <andre@linux-ide.org> wrote:
> 
> So Alex,
> 
> What did you do prior to flush cache being added or did you care?
Never had a problem.

> but it will have to wait unless Marcelo wants it fixed and doing
> half way solutions does not cut it.  If it is wrong in -ac that is where
> it shall be fixed first.
> 
I propose getting rid of the lines in ide_notify_disk that put the disk
in standby mode. The cache is already being flushed in the cleanup()
function. I can generate a patch against 2.4.19 ac4. 

__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
