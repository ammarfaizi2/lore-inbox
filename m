Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbTFYWim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbTFYWim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:38:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35969
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265135AbTFYWil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:38:41 -0400
Subject: Re: 2.4.21: kernel BUG at ide-iops.c:1262!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Scott McDermott <vaxerdec@frontiernet.net>
Cc: David Dillow <dave@thedillows.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030625184723.L9583@newbox.localdomain>
References: <1056493150.2840.17.camel@ori.thedillows.org>
	 <20030624204828.I30001@newbox.localdomain>
	 <1056513292.3885.2.camel@ori.thedillows.org>
	 <1056542418.2460.22.camel@dhcp22.swansea.linux.org.uk>
	 <20030625184723.L9583@newbox.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056581390.2005.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Jun 2003 23:49:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-25 at 23:47, Scott McDermott wrote:
> is this what
> 
> o       First crack at fixing the ide reset oopses      (me)
> 
> tries to fix?
> 
> The CDRW devices that have problems with Test Unit Ready
> during finalization (like the GCC-4240N) are broken and this
> won't fix that problem, but the fix you're talking about
> will stop the kernel from crashing when it happens, do I
> have that right?

The TUA thing is a bit different but the general problem of 
reset being mishandled is part of it and needs fixing anyway

