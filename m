Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319063AbSIJAat>; Mon, 9 Sep 2002 20:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319064AbSIJAat>; Mon, 9 Sep 2002 20:30:49 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:34245 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S319063AbSIJAas>; Mon, 9 Sep 2002 20:30:48 -0400
Subject: Re: [BK PATCH] USB changes for 2.5.34
From: Nicholas Miell <nmiell@attbi.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0209091714330.2069-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0209091714330.2069-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Sep 2002 17:35:27 -0700
Message-Id: <1031618129.1403.12.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 17:17, Linus Torvalds wrote:
> 
> Greg, please don't do this
> 
> > ChangeSet@1.614, 2002-09-05 08:33:20-07:00, greg@kroah.com
> >   USB: storage driver: replace show_trace() with BUG()
> 
> [ cut "BUG() is for fatal errors only" ]
> 
> 		Linus
> 

show_trace isn't exported for modules, and (even worse) isn't even
implemented on all architectures, IIRC.
- Nicholas

