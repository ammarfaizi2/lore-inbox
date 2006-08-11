Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWHKTqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWHKTqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWHKTqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:46:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:19902 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932370AbWHKTqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:46:53 -0400
Date: Fri, 11 Aug 2006 14:46:47 -0500
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>
Subject: Re: [PATCH 4/4]: powerpc/cell spidernet ethtool -i version number info.
Message-ID: <20060811194647.GO10638@austin.ibm.com>
References: <20060811180013.GB6550@pb15.lixom.net> <OF934FE4E3.EEC44FDD-ON872571C7.00668651-862571C7.00677A44@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF934FE4E3.EEC44FDD-ON872571C7.00668651-862571C7.00677A44@us.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Olof,

Olof Johansson <olof@lixom.net> writes:
> On Fri, Aug 11, 2006 at 12:11:17PM -0500, Linas Vepstas wrote:
> 
> > This patch adds version information as reported by 
> > ethtool -i to the Spidernet driver.
> 
> Why does a driver that's in the mainline kernel need to have a version
> number besides the kernel version?

I'll let Jim be the primary defender. From what I can tell, "that's the
way its done".  For example:

linux-2.6.18-rc3-mm2 $ grep MODULE_VERSION */*/*.c |wc
     164     245    9081

> I can understand it for drivers like e1000 that Intel maintain outside
> of the kernel as well. But spidernet is a fully mainline maintained
> driver, right?

Yes, the spidernet is a Linux-kernel only driver.

--linas

p.s. very strange, but I did not see your original email;  
only saw Jim's reply.


