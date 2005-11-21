Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVKUHMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVKUHMQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 02:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbVKUHMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 02:12:16 -0500
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:17645
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP
	id S1750999AbVKUHMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 02:12:15 -0500
Message-ID: <20051121071213.1135.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-0.27
To: Frank Sorenson <frank@tuxrocks.com>
cc: Dag Nygren <dag@newtech.fi>, Nish Aravamudan <nish.aravamudan@gmail.com>,
       linux-kernel@vger.kernel.org, dag@newtech.fi
Subject: Re: nanosleep with small value 
In-Reply-To: Message from Frank Sorenson <frank@tuxrocks.com> 
   of "Thu, 17 Nov 2005 12:47:09 MST." <437CDE3D.90606@tuxrocks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 Nov 2005 09:12:13 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Dag Nygren wrote:
> > But what is the point of having a nanosleep() in that case when you could do
> > just fine with usleep() ?
> 
> I'd suggest looking into the kthrt patches (which incorporates ktimers
> and John Stultz's timeofday patches):  http://www.tglx.de/projects/ktimers/

Thanks for that tip. This completely solved my problem; The program works 
again.

There seems to be two "competing" patches out there, but this seems to be the 
way
to go as the kernel bunch is behind it.

Best

Dag

