Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316820AbSGBQFR>; Tue, 2 Jul 2002 12:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSGBQFQ>; Tue, 2 Jul 2002 12:05:16 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:25050 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316820AbSGBQFQ>; Tue, 2 Jul 2002 12:05:16 -0400
Date: Tue, 2 Jul 2002 18:07:12 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.24] RTL8139: ioctl(SIOCGIFHWADDR): No such device
Message-ID: <20020702160712.GA8921@neon.hh59.org>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
References: <20020701202026.GA896@neon.hh59.org> <3D20BB85.7030504@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D20BB85.7030504@mandrakesoft.com>
User-Agent: Mutt/1.4i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff!

On Mon, 01 Jul 2002, Jeff Garzik wrote:

> >Have not tried 2.5.23 but 2.5.22 works fine. Since there have been changes 
> >to the 8139too driver I guess thats it. Unfortunately I do not know where 
> >to fix
> >this.
> 
> None that should affect this, however.
> 
> Can you please copy your 2.5.22 drivers/net/8139too.c into 2.5.24, and 
> test 2.5.24 with the older driver?

Ok. I copied 8139too driver of 2.5.22 to 2.5.24 and it it was still the same.

I attached output of "lspci -vvv" and "dmesg".

"ifconfig eth1 up" returns with something like "device not found".

Regards,
Axel
