Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTEYNIz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 09:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbTEYNIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 09:08:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28545 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262098AbTEYNIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 09:08:53 -0400
Message-ID: <3ED0C364.3020507@pobox.com>
Date: Sun, 25 May 2003 09:21:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: john@grabjohn.com
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFR] a new SCSI driver
References: <200305250944.h4P9i5Ct000456@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200305250944.h4P9i5Ct000456@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john@grabjohn.com wrote:
>>Serial ATA is looming quickly on the horizon.  Both device and host
>>controller SATA implementations really lend themselves to behaviors
>>that have existed in SCSI for a while.  SATA even defines use of SCSI
>>Enclosure Services.
> 
> 
> Thinking ahead, by the 2.8 timescale, PATA could well be legacy hardware 
> which could be supported only by an 'old' IDE driver, much like we already
> have at the moment - I.E. we could remove the current 'old' IDE driver
> sometime during the 2.7 timescale, and support SATA only via the SCSI layer.
> 
> This would save having any more than the minimum SATA code going in to the
> existing IDE driver, and consolidate work in the future.        


I'm content to let evolution make these decisions...  predicting into 
the future isn't the best skill a technologist has :)

	Jeff



