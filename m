Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSEFMyn>; Mon, 6 May 2002 08:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314433AbSEFMym>; Mon, 6 May 2002 08:54:42 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:36759 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314422AbSEFMym>; Mon, 6 May 2002 08:54:42 -0400
Date: Mon, 6 May 2002 14:33:34 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Tim Waugh <twaugh@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add NetMos 9835 to parport_serial
In-Reply-To: <20020506133809.G27042@redhat.com>
Message-ID: <Pine.LNX.4.44.0205061430150.12156-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002, Tim Waugh wrote:

> Well, if { 2, 3 } works then { 2, -1 } will surely work, although
> without ECP support.  I didn't realise that NetMos cards had ECP
> support at the time I wrote the above code.

My ignorance rears itself ;) I got the numbers from messing with 
pci_resource_start, and got ECP etc detected, although with 
PARPORT_IRQ_NONE, we might as well do -1 anyway since parport_pc didn't 
detect ECP with no irq.

	Zwane

-- 
http://function.linuxpower.ca
		

