Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267400AbUHJCMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbUHJCMQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 22:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbUHJCMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 22:12:16 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:51379 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267400AbUHJCMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 22:12:14 -0400
Date: Mon, 9 Aug 2004 19:12:09 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: greg@kroah.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Remove spaces from PCI IDE pci_driver.name field
Message-ID: <20040810021209.GA10495@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040810001316.GA7292@plexity.net> <1092096699.14934.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092096699.14934.4.camel@localhost.localdomain>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 10 2004, at 01:11, Alan Cox was caught saying:
> On Maw, 2004-08-10 at 01:13, Deepak Saxena wrote:
> > Spaces in driver names show up as spaces in sysfs. Annoying.  
> > I went ahead and changed ones that don't have spaces to use
> > ${NAME}_IDE so they are all consistent.
> 
> I don't see the problem with spaces in the filenames. I do see the 
> problem in changing stuff under people for now reason other than
> "I don't like it".
> 
> The existing format with spaces looks a lot better in all the
> graphical file managers.

Files w/o spaces look better and is easier to work with if running 
from cmd line, but if we ignore the "prettyness" issue, we should at 
least try to be consistent. Either we have spaces and _all_ driver 
names are in the format "xxx IDE", "xxx i2c", etc, or we don't allow
space at all. 

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
