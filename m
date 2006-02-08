Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWBHNhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWBHNhg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 08:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWBHNhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 08:37:36 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:3812 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S964850AbWBHNhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 08:37:35 -0500
Message-ID: <43E9F41C.30204@bootc.net>
Date: Wed, 08 Feb 2006 13:37:32 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Mail/News 1.5 (X11/20060114)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata PATA status report on 2.6.16-rc1-mm5
References: <33D367D1-870E-46AE-A7EC-C938B51E816F@bootc.net> <1139400278.26270.10.camel@localhost.localdomain>
In-Reply-To: <1139400278.26270.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2006-02-08 at 09:58 +0000, Chris Boot wrote:
>> and everything seems to work fine. I notice PATA CD-ROMs still aren't  
>> being recognised (with libata.atapi_enabled=1) which is a bit of a  
>> shame, but fortunately I won't be needing to use the CD-ROM on this  
>> machine at all. In fact this machine has so little use that I'm quite  
>> happy to surrender it to testing.
> 
> What ports are the CDROM devices attached to. I'd expect to see them
> found and reported as "being ignored" so it may indicate a bigger
> problem.
> 
> 

The HDD (that works) is Primary Master, the CD-RW is Secondary Master. I'll give 
-rc2-mm1 a shot later today, and maybe even -rc2 with your separate patches and 
let you know.

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
