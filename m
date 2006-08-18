Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWHRLXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWHRLXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWHRLXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:23:54 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:42384 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932414AbWHRLXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:23:53 -0400
Subject: Re: [patch 2/5] -fstack-protector feature: Add the Kconfig option
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200608181308.07752.ak@suse.de>
References: <1155746902.3023.63.camel@laptopd505.fenrus.org>
	 <1155747038.3023.67.camel@laptopd505.fenrus.org>
	 <200608181308.07752.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Aug 2006 13:23:26 +0200
Message-Id: <1155900206.4494.141.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 13:08 +0200, Andi Kleen wrote:
> On Wednesday 16 August 2006 18:50, Arjan van de Ven wrote:
> > Subject: [patch 2/5] Add the Kconfig option for the stackprotector feature
> > From: Arjan van de Ven <arjan@linux.intel.com>
> >
> > This patch adds the config options for -fstack-protector.
> 
> Normally it's better to add the CONFIG options after the code or 
> at the same time. Otherwise binary searches later can break

the binary search argument in this case is moot, just having a config
option doesn't break anything compile wise and each later step is
self-compiling..

