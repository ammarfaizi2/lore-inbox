Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWDZOwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWDZOwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWDZOwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:52:19 -0400
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:29705 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932463AbWDZOwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:52:18 -0400
Message-ID: <444F891B.3050808@atipa.com>
Date: Wed, 26 Apr 2006 09:52:11 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2
References: <8E8F647D7835334B985D069AE964A4F7011B260D@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7011B260D@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Apr 2006 14:44:07.0889 (UTC) FILETIME=[DF6BFC10:01C6693F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fortier,Vincent [Montreal] wrote:
> Is your OS installed either sda or sdb?
> 
> Because I get this type of message using a single disk... On which my FC5 stands...
> 
> I'll give it a try tonight and see if I can cause the problem manually but I doubt I'll be able to stop the system from hanging...  Unless my bug is not related.
> 
> - vin
> 
>

Vin,

Please don't top post, many will yell at you on this list for that.

OS is on sda, nothing is on sdb which is probably why I don't have the
behavior happening at unexpected times, sdb won't be used except for
during my test.

I believe I am seeing similar behavior on sata_mv controllers so
it might be a more basic problem in libata, and not related to the specific
sata_nv driver at all.

                                     Roger
