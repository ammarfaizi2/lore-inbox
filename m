Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319734AbSIMSC1>; Fri, 13 Sep 2002 14:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319736AbSIMSC1>; Fri, 13 Sep 2002 14:02:27 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:22692 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S319734AbSIMSC0> convert rfc822-to-8bit; Fri, 13 Sep 2002 14:02:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: jimsibley@earthlink.net
Subject: Re: [No Subject]
Date: Fri, 13 Sep 2002 13:02:57 -0500
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br,
       vda@port.imtp.ilyichevsk.odessa.ua, alan@lxorguk.ukuu.org.uk
References: <Springmail.0994.1031938758.0.73924900@webmail.pas.earthlink.net>
In-Reply-To: <Springmail.0994.1031938758.0.73924900@webmail.pas.earthlink.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209131302.57197.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 12:39 pm,  Jim Sibley wrote:
> First, please change your replies to me to jimsibley@earthlink.net and drop
> the IBM address. Some of my replies may not reflect IBM's position.
>
> Also please drop the LTC address in your replies. I'm told that the address
> is not a
> place to discuss issues like this. So much for monolithic turf wars.
>
> Anyway, back to the important stuff.
>
> GID might be sufficient if you reserve some GID for resource balancing and
> use the /proc interface to update it.

Only when a process can have one gid.

This usually means a single user/application system, in which case you
still can't determine which process to kill since they are all in the same
group.

Most production shops I have worked in requires multiple groups per user,
which gets translated into multiple GIDs per process. This defeats your
use of GIDs for resource allocation.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
