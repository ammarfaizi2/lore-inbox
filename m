Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTLAWAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 17:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTLAWAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 17:00:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6597 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264095AbTLAWAm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 17:00:42 -0500
Message-ID: <3FCBB9F3.6050000@pobox.com>
Date: Mon, 01 Dec 2003 17:00:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
CC: Samuel Flory <sflory@rackable.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
References: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet>	<3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv>	<3FCBB15F.7050505@rackable.com> <87ad6ccixk.fsf@stark.dyndns.tv>
In-Reply-To: <87ad6ccixk.fsf@stark.dyndns.tv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:
> Is there any documentation about what libata is and what it does differently
> from the stock kernel? Why is it being developed separately instead of as a

Nothing "different" from the stock kernel; this is how all drivers are 
developed.  libata is the Serial ATA driver for Linux.  Some chipsets -- 
ICH5 and VIA SATA notably -- look so much like PATA that it's easy to 
let the existing drivers/ide driver use them.  You won't get SATA 
hotplug or similar SATA-only features, but as long as you can access 
your SATA hard drive, who cares?  :)

libata is in the "stock" 2.6 kernel, FWIW, too.

	Jeff




