Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265769AbTIJUXu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbTIJUXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:23:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28387 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265763AbTIJUXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:23:46 -0400
Message-ID: <3F5F8845.9080405@pobox.com>
Date: Wed, 10 Sep 2003 16:23:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: acpi-devel@lists.sourceforge.net,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ACPI patch flow
References: <BF1FE1855350A0479097B3A0D2A80EE009FD58@hdsmsx402.hd.intel.com>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FD58@hdsmsx402.hd.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:
> I've re-named the linux-acpi* tree to be linux-acpi-release*; and made
> the staging area for the release tree visible -- calling it
> linux-acpi-test*
> 
> So a 2 stage release is now visible on the net:

cool!


> As before, the BK trees live here:  http://linux-acpi.bkbits.com  If
> there is demand for plain patches of the _test_ tree we can probably
> also export those on http://sourceforge.net/projects/acpi too, but as
> the test tree will change more often, those updates would have to be
> on-demand or on significant events.

I definitely support the posting of plain patches, and strongly 
encourage it.  We don't want any barriers at all to people testing the 
latest ACPI fixes.

May I make a humble suggestion?  :)  Whenever net driver stuff gets send 
off, I'll often run a prepared script which will create a GNU diff 
against mainline, gzip it, and upload it to ftp.kernel.org.  That gives 
the non-BK users patches to play with.

I first considered posting these net driver patches on sourceforge 
(project: gkernel), but uploads to sourceforge are time-consuming 
events.  You have a upload to an FTP site, then fill out a bunch of 
forms and click a bunch of buttons.  It's a system that _discourages_ 
frequent software postings, IMO.

So, my suggestion is to get an account on some web/ftp site 
(kernel.org?) and create a script that combines two tasks (bk push and 
GNU patch upload) into a single command you run on your local Linux box. 
  Properly scripted, posting a patch shouldn't be any more work than 
pushing to your new test tree.  And IMHO you will reap the benefits.

	Jeff



