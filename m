Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbULWJFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbULWJFu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 04:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbULWJFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 04:05:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53222 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261181AbULWJFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 04:05:45 -0500
Date: Thu, 23 Dec 2004 10:05:05 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: the patch of restore-pci-config-space-on-resume break S1 on ASUS2400 NE
Message-ID: <20041223090505.GA7251@devserv.devel.redhat.com>
References: <3ACA40606221794F80A5670F0AF15F84069D51E8@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84069D51E8@pdsmsx403>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 04:51:09PM +0800, Yu, Luming wrote:
>  Hi,
> 
> Since 2.6.7, the Changes for drivers/pci/pci-driver.c@1.37 make my
> ASUS 2400NE hang on S1 resume. 

we need to figure out which device can't take the pci config space
restore...

