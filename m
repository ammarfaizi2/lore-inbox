Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbULGUNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbULGUNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 15:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbULGUNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 15:13:37 -0500
Received: from ida.rowland.org ([192.131.102.52]:18692 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261909AbULGUNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 15:13:08 -0500
Date: Tue, 7 Dec 2004 15:13:07 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, <greg@kroah.com>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [2.6 patch] USB uhci-debug.c: remove an unused
 function (fwd)
In-Reply-To: <20041207193510.GY7250@stusta.de>
Message-ID: <Pine.LNX.4.44L0.0412071511590.647-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004, Adrian Bunk wrote:

> 
> The patch forwarded below still applies and compiles against 
> 2.6.10-rc2-mm4.
> 
> Please apply.
> 
> 
> ----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----
> 
> Date:	Fri, 29 Oct 2004 02:30:16 +0200
> From: Adrian Bunk <bunk@stusta.de>
> To: stern@rowland.harvard.edu
> Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
> 	linux-kernel@vger.kernel.org
> Subject: [2.6 patch] USB uhci-debug.c: remove an unused function
> 
> The patch below removes an unused function from 
> drivers/usb/host/uhci-debug.c
> 
> 
> diffstat output:
>  drivers/usb/host/uhci-debug.c |   11 -----------
>  1 files changed, 11 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.10-rc1-mm1-full/drivers/usb/host/uhci-debug.c.old	2004-10-28 23:30:40.000000000 +0200
> +++ linux-2.6.10-rc1-mm1-full/drivers/usb/host/uhci-debug.c	2004-10-28 23:30:49.000000000 +0200
> @@ -34,17 +34,6 @@
>  	}
>  }
>  
> -static inline int uhci_is_skeleton_qh(struct uhci_hcd *uhci, struct uhci_qh *qh)
> -{
> -	int i;
> -
> -	for (i = 0; i < UHCI_NUM_SKELQH; i++)
> -		if (qh == uhci->skelqh[i])
> -			return 1;
> -
> -	return 0;
> -}
> -
>  static int uhci_show_td(struct uhci_td *td, char *buf, int len, int space)
>  {
>  	char *out = buf;
> -

This has my approval.

Alan Stern

