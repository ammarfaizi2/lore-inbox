Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRABQWd>; Tue, 2 Jan 2001 11:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbRABQWX>; Tue, 2 Jan 2001 11:22:23 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:21888 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S130018AbRABQWL>; Tue, 2 Jan 2001 11:22:11 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <0012280214100G.32196@www.easysolutions.net> 
In-Reply-To: <0012280214100G.32196@www.easysolutions.net> 
To: shane@agendacomputing.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting from a non block device 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Jan 2001 15:51:18 +0000
Message-ID: <2676.978450678@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


shane@agendacomputing.com said:
>  The main.c file is hardwired to boot from a block device, and as such
> I can't  think of a good way to get around it and put in a filesystem
> instead.  Should  I just cheat and put in a fake block device?  

That's what NFSroot does. I suppose you could also argue that's what JFFS 
does too, because it doesn't actually _use_ the mtdblock device for 
anything but getting a handle on the underlying MTD device.



--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
