Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263788AbUFBSEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbUFBSEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUFBSBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:01:31 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:28830 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S263763AbUFBR7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:59:12 -0400
From: Manu Abraham <manu@kromtek.com>
Reply-To: manu@kromtek.com
Organization: Kromtek Systems
To: linux-kernel@vger.kernel.org
Subject: Re: Minor numbers under 2.6
Date: Wed, 2 Jun 2004 21:49:30 +0400
User-Agent: KMail/1.5.4
References: <200406021519.32128.manu@kromtek.com> <20040602144931.GA25424@kroah.com>
In-Reply-To: <20040602144931.GA25424@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406022149.30180.manu@kromtek.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 Jun 2004 6:49 pm, Greg KH wrote:
> On Wed, Jun 02, 2004 at 03:19:32PM +0400, Manu Abraham wrote:
> > Hi,
> > 	Can somebody clarify a question that i have ?
> >
> > 	Say under 2.4 kernel, char device drivers had a minor number of int. In
> > the 2.6 kernels, this number was increased to 20 bits from 8 bits. Under
> > 2.6 i could use "mknod -c major, minor".
> >
> > 	How can i achieve something similar with 2.6 taking into consideration
> > that i have to create more than 255 minors ?
>
> The same way:
> 	# mknod foo c 100 10000
> 	# ls -l foo
> 	crw-r--r--  1 root root 100, 10000 Jun  2 07:48 foo
>
> Just make sure you have a up to date glibc.
>
> Hope this helps,
>
> greg k-h


	Thanks a lot, I was breaking my head to understand what the hell was going 
on.

Thanks again,

Regards,
Manu

