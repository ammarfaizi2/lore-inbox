Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbTH2SAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTH2SAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:00:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56507 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261693AbTH2SAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:00:07 -0400
Message-ID: <3F4F949B.6030900@pobox.com>
Date: Fri, 29 Aug 2003 13:59:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Samuel Flory <sflory@rackable.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: libata update posted (was Re: VIA Serial ATA chipset)
References: <20030813074535.C3AB427AC8@mail.medav.de> <3F4F6863.4080400@pobox.com> <3F4F8BA7.1080002@rackable.com>
In-Reply-To: <3F4F8BA7.1080002@rackable.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Flory wrote:
> Jeff Garzik wrote:
>> Changes:
>> * continue work towards fully async taskfile API:  you call 
>> submit_tf(), and later on, your callback is called when the taskfile 
>> completes or times out.   async taskfile API is required for ATAPI and 
>> supporting more advanced host controllers like Promise or AHCI (SATA2).
>> * some cleanups

>   I'm guessing there is no support for Promise yet?

Not yet.  Once I finish the item mentioned above, "async taskfile API", 
Promise support will appear quite rapidly.


> PS-  The driver works great on the silcon image chipset.  (Once I 
> realized that my Seagate drive needed newer firmware.)

Um... libata doesn't support Silicon Image yet?

	Jeff



