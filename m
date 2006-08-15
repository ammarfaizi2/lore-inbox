Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWHOTKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWHOTKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbWHOTKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:10:21 -0400
Received: from lixom.net ([66.141.50.11]:19420 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1030409AbWHOTKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:10:19 -0400
Date: Tue, 15 Aug 2006 14:05:24 -0500
To: James K Lewis <jklewis@us.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       Linas Vepstas <linas@austin.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH 4/4]: powerpc/cell spidernet ethtool -i version number info.
Message-ID: <20060815190524.GW6603@pb15.lixom.net>
References: <20060811180013.GB6550@pb15.lixom.net> <OF934FE4E3.EEC44FDD-ON872571C7.00668651-862571C7.00677A44@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF934FE4E3.EEC44FDD-ON872571C7.00668651-862571C7.00677A44@us.ibm.com>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 01:50:19PM -0500, James K Lewis wrote:
>  Hi Olof,
> 
>   There are several reasons why an Ethernet driver should have an up to 
> date version number:
> 
> 1. Customers like to see they are really getting a new version.
> 
> 2. It makes it easier for support personnel (me in this case) to see which 
> driver they have. Sure, sometimes I can talk them thru doing a "sum" on 
> the .ko and all that, but why not just use the version number? That's what 
> it is for. And no, you can't just assume they have the version that came 
> with the kernel they are running. It doesn't work that way.
> 
> 3. It makes bug reporting easier. 
> 
> 4. I have already run into too many problems and wasted too much time 
> working with drivers when the number was NOT getting updated. 

Thanks for the info, Jim.

Sounds like it's most useful if a customer (or distro) takes the driver
out of the tree and run it with a different kernel, i.e. when kernel
and driver versions no longer go together. Makes sense.


-Olof

