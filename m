Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293373AbSCAQvF>; Fri, 1 Mar 2002 11:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293393AbSCAQvA>; Fri, 1 Mar 2002 11:51:00 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:20753 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S293381AbSCAQus>; Fri, 1 Mar 2002 11:50:48 -0500
Date: Fri, 1 Mar 2002 12:42:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: jurgen@pophost.eunet.be, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre2 - USB - sparc64 compile problem
In-Reply-To: <20020301.073142.24904941.davem@redhat.com>
Message-ID: <Pine.LNX.4.21.0203011241570.3162-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Mar 2002, David S. Miller wrote:

>    From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
>    Date: Fri, 01 Mar 2002 15:09:04 +0100
> 
>    hcd.c: In function `usb_hcd_pci_probe':
>    hcd.c:627: `irq' undeclared (first use in this function)
>    hcd.c:627: (Each undeclared identifier is reported only once
>    hcd.c:627: for each function it appears in.)
> 
> Go to line 627 in an editor and change "irq" to be "dev->irq"
> 
> The same build failure got introduced when this code was merged
> into the 2.5.x tree and I had to fix it there too.

Fixed in my tree.

