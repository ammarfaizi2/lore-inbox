Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUIOQJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUIOQJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUIOQHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:07:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3248 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266611AbUIOQBj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:01:39 -0400
Message-ID: <41486755.3070207@pobox.com>
Date: Wed, 15 Sep 2004 12:01:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Bonin <kernel@bonin.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI coprocessors
References: <41483BD3.4030405@bonin.ca>
In-Reply-To: <41483BD3.4030405@bonin.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Bonin wrote:
> 1) Is their support for having two different 'machine types' within one 
> kernel? that is for example, certain executables for intel would get run 
> on an intel processor, and others would get run on processor with type 
> XXXX.
> 
> I heard once someone put native "java" .class support within the kernel 
> (it would call the jvm run time if i remember).  I could maby do this 
> with my own set of libraries and driver.  But differentiating between 
> the types of executable might be hard.
> 
> 2) Is their kernel support for PCI coprocessors for thread allocation 
> etc.  I couldn't find any but i can try looking through the code again.


You can mix and match processor types all you want...  just treat them 
as completely asynchronous and independent entities.

I have long dreamed of being able to add a PCI card to my x86 system, a 
PCI card containing a processor (of any type), RAM, and an ethernet 
interface.  I would use this for routing, or iSCSI, or network offload...

	Jeff


