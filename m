Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVCPVRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVCPVRj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbVCPVQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:16:11 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:55654 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262802AbVCPVQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:16:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=T8c/GlipFTw90Sx+8Nj172mq3VyilQPbzfqvGWF3ao1mTtCQT20YDOzgMBuPVy8PIsewnaJAOFUKmRy6uTARUonsWGMznNT7i3+Ob9K8cu6FCVcD3/oJsWJnS7n88YBEKRPpWGpaNBiKIfXr9QbbyBY+HmFRkTE9Vts5hyTtLKU=
Message-ID: <564d96fb05031613156ed210c2@mail.gmail.com>
Date: Wed, 16 Mar 2005 18:15:58 -0300
From: =?ISO-8859-1?Q?Rafael_Esp=EDndola?= <rafael.espindola@gmail.com>
Reply-To: =?ISO-8859-1?Q?Rafael_Esp=EDndola?= <rafael.espindola@gmail.com>
To: Colin Leroy <colin@colino.net>
Subject: Re: `dd` problem from cdrom
Cc: linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org
In-Reply-To: <20050316153114.374e095b@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050316153114.374e095b@jack.colino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005 15:31:14 +0100, Colin Leroy <colin@colino.net> wrote:
> Hi,
> 
> Using 2.6.10 and 2.6.11, trying to use dd from the ide cdrom in my
> Ibook G4 fails like this:

> /dev/hdc:
>  HDIO_GET_MULTCOUNT failed: Invalid argument
>  IO_support   =  0 (default 16-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 256 (on)
>  HDIO_GETGEO failed: Invalid argument
I have a cdrom drive that does not work with DMA. Maybe yours has the
same problem.
  
> I didn't try older kernels yet; Any idea about this? Is it a kernel bug
> or a configuration issue? 
> -- 
> Colin
Rafael
