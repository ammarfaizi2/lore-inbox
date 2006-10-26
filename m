Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752124AbWJZMZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbWJZMZj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbWJZMZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:25:39 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:33917 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1752124AbWJZMZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:25:38 -0400
Date: Thu, 26 Oct 2006 14:25:36 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: robert george <robezy.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiling bcm4xx module
Message-ID: <20061026122536.GC12420@harddisk-recovery.com>
References: <5d87a57d0610260408j641545c7oe9f9d74bdb19a321@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d87a57d0610260408j641545c7oe9f9d74bdb19a321@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 04:38:29PM +0530, robert george wrote:
>    i am having 2.6.16-13 kernel .This kernel lack support for broadcom
> wireless card.But the latest kernel is having support for this card.
> 
>   I download the the kernel ,but i would like to compile this particular
> 
> driver only , not the entire kernel.
>   Is it possible???

I don't think so. Bcm43xx needs the ieee80211 subsystem, which also
changed a lot between 2.6.16 and 2.6.18.

>  I tried to execute the following command
>  make -C /usr/src/linux-2.6.16-13 SUBDIRS=$PWD  modules
> 
>  but got following error  message ..
> 
>  ' No reason to target modules'
> 
>  How can i compile the driver separately???

Not against that particular kernel. 


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
