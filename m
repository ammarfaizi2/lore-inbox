Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288709AbSADSJq>; Fri, 4 Jan 2002 13:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288708AbSADSJf>; Fri, 4 Jan 2002 13:09:35 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:29801 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288711AbSADSJ1>; Fri, 4 Jan 2002 13:09:27 -0500
Message-ID: <3C35EFCC.52E7BFD9@redhat.com>
Date: Fri, 04 Jan 2002 18:09:16 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: Error loading e1000.o - symbol not found
In-Reply-To: <1010164038.2030.27.camel@crgs.lowerrd.prv> <Pine.LNX.4.30.0201041900140.29991-100000@mustard.heime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> hm...
> 
> same problem with 2.4.18-pre1
> 
> [root@vs2 src]# modprobe e1000
> /lib/modules/2.4.18-srv1/kernel/drivers/net/e1000.o: unresolved symbol _mmx_memcpy
> /lib/modules/2.4.18-srv1/kernel/drivers/net/e1000.o: insmod
> /lib/modules/2.4.18-srv1/kernel/drivers/net/e1000.o failed
> /lib/modules/2.4.18-srv1/kernel/drivers/net/e1000.o: insmod e1000 failed
> 
> anyone that knows why?

Intel probably uses the wrong set of kernel headers to compile against
