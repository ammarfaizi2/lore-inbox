Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291660AbSBHR1o>; Fri, 8 Feb 2002 12:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291665AbSBHR1b>; Fri, 8 Feb 2002 12:27:31 -0500
Received: from www.transvirtual.com ([206.14.214.140]:51982 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291660AbSBHR1O>; Fri, 8 Feb 2002 12:27:14 -0500
Date: Fri, 8 Feb 2002 09:26:30 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Jani Monoses <jani@astechnix.ro>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] Tridentfb and resource management
In-Reply-To: <Pine.GSO.4.21.0202081741140.19681-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.10.10202080925580.18628-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Since Tridentfb uses resource management, its initialization must be done
> before the initialization of the generic drivers (vesafb and offb).

I assume you mean the pci_resource_xxx stuff. We really need to move all
the drivers to this.


