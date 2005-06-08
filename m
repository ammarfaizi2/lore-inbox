Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVFHRot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVFHRot (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVFHRos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:44:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:18386 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261463AbVFHRnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:43:51 -0400
Message-ID: <42A72E4F.4040700@pobox.com>
Date: Wed, 08 Jun 2005 13:43:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert White <rwhite@casabyte.com>
CC: Kumar Gala <kumar.gala@freescale.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: stupid SATA questions
References: <10d4b7cd189d7b661a84e765ab8cce93@freescale.com> <42A5E0BF.8000103@pobox.com> <42A711FE.2080004@casabyte.com>
In-Reply-To: <42A711FE.2080004@casabyte.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert White wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Since the title of the thread applies...
> 
> What command (or whatever) does one use to do things like set the power
> controls on a libata-controlled SATA drive?  hdparm doesn't seem to do
> anything but complain when I try to use the various features.

You need "ATA passthru" (SMART support) in order for hdparm to work.


> hdparm /dev/sda
> /dev/sda:
>  IO_support   =  0 (default 16-bit)
>  ...
> 
> Does the "16-bit" mean anything or is it just a bogon?

This is hardcoded.  I doubt you will ever be able to change this.

	Jeff


