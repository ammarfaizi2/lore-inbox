Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265628AbSKAFy3>; Fri, 1 Nov 2002 00:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265629AbSKAFy3>; Fri, 1 Nov 2002 00:54:29 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:30472 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S265628AbSKAFy2>; Fri, 1 Nov 2002 00:54:28 -0500
Date: Fri, 1 Nov 2002 17:00:43 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: What's left over.
In-Reply-To: <1036092043.8575.116.camel@irongate.swansea.linux.org.uk>
Message-ID: <Mutt.LNX.4.44.0211011649190.25808-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Oct 2002, Alan Cox wrote:

> Chris is write that crypto api is misdesigned if we want to use hardware
> cryptocards

Hardware support was not an initial goal, as the requirements are not yet 
fully known.

>From Documentation/crypto/api-intro.txt:

  An asynchronous scheduling interface is in planning but not yet
  implemented, as we need to further analyze the requirements of all of
  the possible hardware scenarios (e.g. IPsec NIC offload).

Hardware accelerators are generally a known issue, with already proven 
solutions (e.g. the OpenBSD crypto queue).  We don't know much about IPSec 
NIC offload yet, however.


- James
-- 
James Morris
<jmorris@intercode.com.au>


