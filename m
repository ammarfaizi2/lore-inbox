Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292754AbSCDXsA>; Mon, 4 Mar 2002 18:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292764AbSCDXru>; Mon, 4 Mar 2002 18:47:50 -0500
Received: from callisto.affordablehost.com ([64.23.37.14]:36016 "HELO
	callisto.affordablehost.com") by vger.kernel.org with SMTP
	id <S292754AbSCDXrn>; Mon, 4 Mar 2002 18:47:43 -0500
Message-ID: <3C8407C0.1000503@keyed-upsoftware.com>
Date: Mon, 04 Mar 2002 17:48:16 -0600
From: David Stroupe <dstroupe@keyed-upsoftware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Q:Shared IRQ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have written a driver for a pci board that uses interrupts.  I install 
the shared handler with a unique dev_id, or at least it should be unique 
as it is the address of my driver's internal data struct for that card. 
 I get not only my interrupts, but also the interrupts of the shared 
device, namely the network card.  Is this what I should expect?  If I 
get a notification for the network card, why is the dev_id the same as 
what I passed?  If I didn't have an interrupt pending bit on my 
hardware, how would I distinguish between the interrupts?

TIA

-- 
Best regards,
David Stroupe
Keyed-Up Software 


