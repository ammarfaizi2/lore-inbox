Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269596AbRHCUud>; Fri, 3 Aug 2001 16:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269597AbRHCUuY>; Fri, 3 Aug 2001 16:50:24 -0400
Received: from moline.gci.com ([205.140.80.106]:16139 "EHLO moline.gci.com")
	by vger.kernel.org with ESMTP id <S269596AbRHCUuO>;
	Fri, 3 Aug 2001 16:50:14 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA315053E1478@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Justin Guyett <justin@soze.net>,
        Anders Eriksson <aer-list@mailandnews.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: link status changes forwarded to userspace?
Date: Fri, 3 Aug 2001 12:50:06 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Guyett [justin@soze.net] responded to:
> On Fri, 3 Aug 2001, Anders Eriksson wrote:
> 
>> Is it possible to get the link status change (e.g. eth 
>> cable inserted in card) forwarded to userspace? 
> 
> mii-tool does it (comes with net-tools).

This works great for pci-based 10/100 cards, however when I
try it on my 10-meg only ISA-3c509 (eth[0-1]) and PCI-de4x5 (eth2):

mii-diag eth[0-2]
SIOCGMIIPHY on eth[0-2] failed: operation not supported

so probably there's more to it than just using mii-diag..

