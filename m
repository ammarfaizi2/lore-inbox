Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWEQWVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWEQWVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWEQWVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:21:10 -0400
Received: from ns1.suse.de ([195.135.220.2]:5823 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751246AbWEQWVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:21:08 -0400
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 17/22] [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
Date: Thu, 18 May 2006 00:16:04 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       len.brown@intel.com, Greg Kroah-Hartman <gregkh@suse.de>
References: <20060517221312.227391000@sous-sol.org> <20060517221412.058186000@sous-sol.org>
In-Reply-To: <20060517221412.058186000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605180016.05127.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 May 2006 09:00, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------

Who submitted that? I didn't

There seems to be some controversy about this patch so better not put 
it into stable for now.

-Andi

> 
> This is needed to see all devices.
> 
> The system has multiple PCI segments and we don't handle that properly
> yet in PCI and ACPI. Short term before this is fixed blacklist it to
> pci=noacpi.
>
