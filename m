Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422809AbWHYBJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422809AbWHYBJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 21:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422816AbWHYBJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 21:09:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59866 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422809AbWHYBJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 21:09:44 -0400
Date: Thu, 24 Aug 2006 18:09:27 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update Documentation/devices.txt
Message-Id: <20060824180927.88742491.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.1; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sync Documentation/devices.txt with the new version from the LANANA
> site (http://www.lanana.org/docs/device-list/devices-2.6+.txt)

This doesn't look like a "sync". More like a "replacement, discarding
changes".

> @@ -1522,7 +1522,7 @@ Your cooperation is appreciated.
>  		disks (see major number 3) except that the limit on
>  		partitions is 15.
>  
> - 83 char	Matrox mga_vid video driver
> + 83 char	Matrox mga_vid video driver 
> @@ -1731,7 +1731,7 @@ Your cooperation is appreciated.
>  		  0 = /dev/ubda		First user-mode block device
>  		 16 = /dev/udbb		Second user-mode block device
>  		    ...
> -
> +		

Nice trailing space! I don't remember this happening when HPA was
in charge.

> @@ -2565,10 +2565,10 @@ Your cooperation is appreciated.
>  		243 = /dev/usb/dabusb3	Fourth dabusb device
>  
>  180 block	USB block devices
> -		  0 = /dev/uba		First USB block device
> -		  8 = /dev/ubb		Second USB block device
> -		 16 = /dev/ubc		Third USB block device
> -		    ...
> +		0 = /dev/uba		First USB block device
> +		8 = /dev/ubb		Second USB block device
> +		16 = /dev/ubc		Third USB block device
> + 		    ...
>  
>  181 char	Conrad Electronic parallel port radio clocks

Please do not apply this.

-- Pete
