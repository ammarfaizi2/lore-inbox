Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284010AbRLWTeJ>; Sun, 23 Dec 2001 14:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284073AbRLWTeB>; Sun, 23 Dec 2001 14:34:01 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:61960 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284010AbRLWTds>;
	Sun, 23 Dec 2001 14:33:48 -0500
Date: Sun, 23 Dec 2001 11:29:41 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Phil Brutsche <pbrutsch@tux.creighton.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.17 compile error + fix
Message-ID: <20011223112941.C4493@kroah.com>
In-Reply-To: <1009081736.968.0.camel@fury> <3C256851.CD91C2A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C256851.CD91C2A@zip.com.au>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 25 Nov 2001 17:09:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2001 at 09:14:57PM -0800, Andrew Morton wrote:
> 
> If uhci_start_usb() fails, the driver still wants to call
> uhci_pci_remove() to clean stuff up.  Same with bttv.

Yes, this is the correct patch for uhci.c.

thanks,

greg k-h
