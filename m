Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVCHFoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVCHFoJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVCHFmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:42:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:39810 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261271AbVCHFlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:41:47 -0500
Date: Mon, 7 Mar 2005 21:39:41 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] resync ATI PCI idents into base kernel
Message-ID: <20050308053941.GA16450@kroah.com>
References: <200503072216.j27MGxtP024504@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503072216.j27MGxtP024504@hera.kernel.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 09:50:19PM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.1982.132.7, 2005/03/07 13:50:19-08:00, alan@lxorguk.ukuu.org.uk
> 
> 	[PATCH] resync ATI PCI idents into base kernel
> 
> 
> 
>  pci_ids.h |   11 +++++++++++
>  1 files changed, 11 insertions(+)
> 
> 
> diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> --- a/include/linux/pci_ids.h	2005-03-07 14:17:11 -08:00
> +++ b/include/linux/pci_ids.h	2005-03-07 14:17:11 -08:00
> @@ -352,10 +352,21 @@
>  #define PCI_DEVICE_ID_ATI_RS300_133	0x5831
>  #define PCI_DEVICE_ID_ATI_RS300_166	0x5832
>  #define PCI_DEVICE_ID_ATI_RS300_200	0x5833
> +#define PCI_DEVICE_ID_ATI_RS350_100     0x7830
> +#define PCI_DEVICE_ID_ATI_RS350_133     0x7831
> +#define PCI_DEVICE_ID_ATI_RS350_166     0x7832
> +#define PCI_DEVICE_ID_ATI_RS350_200     0x7833
> +#define PCI_DEVICE_ID_ATI_RS400_100     0x5a30
> +#define PCI_DEVICE_ID_ATI_RS400_133     0x5a31
> +#define PCI_DEVICE_ID_ATI_RS400_166     0x5a32
> +#define PCI_DEVICE_ID_ATI_RS400_200     0x5a33
> +#define PCI_DEVICE_ID_ATI_RS480         0x5950

Was there a reason you did this without using tabs, like the rest of the
file?

Again, the maintainer chain is well documented...

{sigh}

Oh, no Signed-off-by: line either :(

greg k-h
