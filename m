Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVFFP66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVFFP66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 11:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVFFP6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 11:58:52 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:60689 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261509AbVFFP6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 11:58:39 -0400
Message-ID: <42A472AC.8040307@rtr.ca>
Date: Mon, 06 Jun 2005 11:58:36 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: shelved ioctl-get-identity patch
References: <42A12E80.8090203@pobox.com>
In-Reply-To: <42A12E80.8090203@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> I am removing the attached patch from libata-dev.git, as it does not 
> justify the maintenance burden at the present time.  The reasons it sat 
> in libata-dev rather than go upstream are discussed at the top of the 
> patch.
> 
> If anyone feels strongly about this ioctl, take it upon yourself to 
> research the patch fully, address the concerns, and present an updated 
> solution.

That interface is so obsolete it really doesn't matter much now.
Most people seem to use the more modern "hdparm -I" instead
of this ("hdparm -i") one.

For now, "hdparm -I" works just fine using HDIO_DRIVE_CMD,
but if somebody could show me how to use ATA PASSTHRU,
then I'll port it over to that.

Cheers

