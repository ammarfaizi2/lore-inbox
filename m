Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSG2XrT>; Mon, 29 Jul 2002 19:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSG2XrT>; Mon, 29 Jul 2002 19:47:19 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:22780 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S317326AbSG2XrS> convert rfc822-to-8bit; Mon, 29 Jul 2002 19:47:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
Date: Mon, 29 Jul 2002 18:42:16 -0500
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
References: <200207291454.30076.habanero@us.ibm.com> <200207291558.47266.habanero@us.ibm.com> <1027989445.4050.28.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1027989445.4050.28.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207291842.16145.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 July 2002 7:37 pm, Alan Cox wrote:
> On Mon, 2002-07-29 at 21:58, Andrew Theurer wrote:
> > Agreed, we need some sort of irqbalance, and I intend to test with Ingo's
> > and Andrea's approaches. With that addition, I may even see an
> > improvement with hyperthreading. But for an rc release, I think it would
> > be prudent to revert the "new code" for default hyperthreading behavior,
> > and attack the whole problem in 2.4.20 or later release.
>
> Because your personal workload is slower ?

Well, I would think some here would be interested in samba performance.   
However, If 4-way P4 systems are considered rare at this point I guess it's 
not important enough to revert.  FYI, after testing 2P with and without 
hyperthreading, it's much faster.  481 Mbps for no hyperthreading and 605 
Mbps with.  If I can get even close to that improvement with 4 processors, 
I'll be very happy.   

-Andrew Theurer

