Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281681AbRKUI6k>; Wed, 21 Nov 2001 03:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281682AbRKUI6c>; Wed, 21 Nov 2001 03:58:32 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:44798 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281681AbRKUI6V>; Wed, 21 Nov 2001 03:58:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: David Woodhouse <dwmw2@infradead.org>, Dale Amon <amon@vnl.com>
Subject: Re: A return to PCI ordering problems...
Date: Wed, 21 Nov 2001 08:57:47 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011120190316.H19738@vnl.com> <2048.1006291657@redhat.com>
In-Reply-To: <2048.1006291657@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166TCM-0004VH-00@lilac.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 November 2001 9:27 pm, David Woodhouse wrote:
> amon@vnl.com said:
> > In any case, here is the problem:
> > 	NIC on motherboard, Realtek
> > 	NIC on PCI card, Realtek
> > 	Monolithic (no-module) kernel
> > 	Motherboard must be set to eth0
>
> Why must the motherboard be set to eth0? Why not just configure it as it
> gets detected?

He has some software licensing thing which checks the MAC address of eth0.

Of course, what he could do is change the MAC address of eth0 to whatever the 
licensing software wants... :-)

> If you really care about the names, there's an ioctl you can use to change
> them. You can call them 'fred' and 'sheila' if you so desire.

So you can you swap them, so eth1 becomes eth0? If so, that should solve his 
problem...


James.
