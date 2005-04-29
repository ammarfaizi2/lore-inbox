Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVD2Goj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVD2Goj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 02:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVD2Goj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 02:44:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:60544 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262443AbVD2Goh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 02:44:37 -0400
Subject: Re: [PATCH 3/4] ppc64: Add driver for BPA iommu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <200504290748.30055.arnd@arndb.de>
References: <200504190318.32556.arnd@arndb.de>
	 <200504290635.44965.arnd@arndb.de> <20050429053615.GA30219@lixom.net>
	 <200504290748.30055.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 16:43:04 +1000
Message-Id: <1114756984.7111.268.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 07:48 +0200, Arnd Bergmann wrote:
> On Freedag 29 April 2005 07:36, Olof Johansson wrote:
> > On Fri, Apr 29, 2005 at 06:35:43AM +0200, Arnd Bergmann wrote:
> >>
> > Anyhow, enum or #define, it should be moved to bpa_iommu.h.
> 
> I don't interface with any other files, so I prefer to have
> everything in one file here. If there is anyone else who
> agrees with you on moving this into a separate file, I don't
> mind doing that.

The habit here is for such "private" .h to be next to the .c, while a
shared one goes in include/asm-* or include/linux.

Ben.


