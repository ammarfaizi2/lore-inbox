Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317304AbSHGLfF>; Wed, 7 Aug 2002 07:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317327AbSHGLfF>; Wed, 7 Aug 2002 07:35:05 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:42232 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317304AbSHGLfE>; Wed, 7 Aug 2002 07:35:04 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0208061714560.16357-100000@rancor.yyz.somanetworks.com> 
References: <Pine.LNX.4.33.0208061714560.16357-100000@rancor.yyz.somanetworks.com> 
To: "Scott Murray" <scottm@somanetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: PCI hotplug resource reservation 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Aug 2002 12:38:41 +0100
Message-ID: <10045.1028720321@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


scottm@somanetworks.com said:
> However, in my quest to avoid duplicating the piles of resource
> manipulation code in the Compaq and IBM hotplug drivers, and use the
> PCI API in the fashion of the Cardbus driver, I've had to implement an
> idea mentioned to me by David Woodhouse at OLS, namely boot-time PCI
> resource reservation. 

ISTR I referred to that as an evil hack.

Is there any particular reason why you can't assign random bits of address 
space to cards and simply fix up the bridges accordingly so that 
transactions for that range are forwarded?

--
dwmw2


