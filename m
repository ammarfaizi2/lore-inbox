Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbWAGONN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWAGONN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 09:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbWAGONN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 09:13:13 -0500
Received: from web32911.mail.mud.yahoo.com ([68.142.206.58]:43435 "HELO
	web32911.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030452AbWAGONM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 09:13:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=kZNLWDKRw+RBqrVrK1RQi/cTpEBvSoETrEvpe/sMr3AA273FYTrWuqnOmnoh9m2fau36PDfvXVz3YSMVcoGqPs5d9S3Zvcwr2uYJJPYSjt9Z+NDceSXJ4NgVjpqI22amBPUBfk/nQBxbRjzOLhGekxmpNexrvzmV/558gtroumk=  ;
Message-ID: <20060107141311.21713.qmail@web32911.mail.mud.yahoo.com>
Date: Sat, 7 Jan 2006 06:13:11 -0800 (PST)
From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [spi-devel-general] [patch 2.6.14-rc6-git 2/6] SPI ads7846 protocol driver
To: David Brownell <david-b@pacbell.net>,
       spi-devel-general@lists.sourceforge.net
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200601031941.48787.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- David Brownell <david-b@pacbell.net> wrote:
> 
> I was thinking of replacing the hacks with spi_bitbang stuff;
> the txrx_bufs() method is appropriate for MicroWire since it
> needs to know whether to read _or_ write, and txrx_word() calls
> assume the full-service shift register is available.

Please post the patch once you replace it spi_bitbang. Thanx.

> 
> 
> > Also use input_allocate_device() instead of init_input_dev().
> Thanx.
> 
> Got patch?  :)

I will do it with latest -mm next week.

> 
> Cool.  tsc2101 + uwire will handle H2 (and H3?) also.  The only
> API change I know of (== necessariy affects your code) will be
> the "spi_transfer.transfer_list" patch, which I'll get out soon.

Ok, I will rebase it with -mm code. I have posted the patch to
linux-omap mailing list, which is not yet complete for OMAP2 SPI master
controller. As I want to avoid duplicate work done by someone in the
another part of world with same fwk for OMAP2 :)

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

