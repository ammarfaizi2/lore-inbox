Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272275AbTG3WNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272276AbTG3WNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:13:05 -0400
Received: from ausadmmsrr504.aus.amer.dell.com ([143.166.83.91]:57618 "HELO
	AUSADMMSRR504.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S272275AbTG3WND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:13:03 -0400
X-Server-Uuid: 5b9b39fe-7ea5-4ce3-be8e-d57fc0776f39
Message-ID: <1059603176.1429.28.camel@localhost.localdomain>
From: Matt_Domsch@Dell.com
To: nelsonis@earthlink.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Dell 2650 Dual Xeon freezing up frequently
Date: Wed, 30 Jul 2003 17:12:56 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 13369D673278838-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-30 at 16:52, Ian S. Nelson wrote:
> I'm running a RedHat 2.4.20 kernel on some 2650's   all dual xeon 
> (pentium 4 jacksonized  so it looks like 4 procsessors)  2 have 1GB of 
> RAM and 1 has 2GB of RAM.   THey all wedge, some times after a few 
> minutes,  sometimes after hours.

Make sure you have an up-to-date tg3 network driver.  There was a brief
period of time around when 2.4.20 was released where it didn't have all
the hardware quirk workarounds in it.  Something in the current 2.4.x
tree should work fine.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

