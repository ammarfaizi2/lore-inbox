Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVELPOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVELPOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 11:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVELPO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 11:14:29 -0400
Received: from holomorphy.com ([66.93.40.71]:61571 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262008AbVELPOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 11:14:25 -0400
Date: Thu, 12 May 2005 08:13:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rudolf Usselmann <rudi@asics.ws>
Cc: Stefan Smietanowski <stesmi@stesmi.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Frank Denis (Jedi/Sector One)" <j@pureftpd.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: kernel (64bit) 4GB memory support
Message-ID: <20050512151345.GG9304@holomorphy.com>
References: <1103646195.3652.196.camel@cpu0> <Pine.LNX.4.61.0412210930280.28648@montezuma.fsmlabs.com> <1103647158.3659.199.camel@cpu0> <Pine.LNX.4.61.0412210955130.28648@montezuma.fsmlabs.com> <1115654185.3296.658.camel@cpu10> <20050509200721.GE2297@csclub.uwaterloo.ca> <1115754522.4409.16.camel@cpu10> <20050511142745.GQ2281@csclub.uwaterloo.ca> <4282D3E1.80303@stesmi.com> <1115870693.8406.53.camel@cpu10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115870693.8406.53.camel@cpu10>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-12 at 05:56 +0200, Stefan Smietanowski wrote:
>>> In 32bit it probably uses the PSE36 extensions or something, which isn't
>>> the same thing as flat 64bit memory access.  It could just be a matter
>>> of needing a memory hole somewhere for PCI space or something.  I only
>>> have 1G in my 64bit machine so I haven't got near these problems.

On Thu, May 12, 2005 at 11:04:53AM +0700, Rudolf Usselmann wrote:
>> I don't recall him saying he's changed kernel from the default redhat
>> kernel in which case he's running the RedHat 4G/4G split kernel and not
>> using PSE/PAE.

PSE36 is 4MB pages (no 4KB pages allowed!), 36-bit physical addresses.


-- wli
