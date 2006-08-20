Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWHTNac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWHTNac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 09:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWHTNac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 09:30:32 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:1680 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750779AbWHTNab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 09:30:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AMrYnPiu2ObSXAtf81YlUVVPqhmEvg7VpXDrNfoH4IdCe/WAJPX/sfvBVGImS85TAYcx9SAxncws8RR8MEeM8d1VPmneMDa/MLuHDf9Og243hluLoYrui56kz7XUKs4kNBBl1IqCKzm3+nTsRtYQaE9ATQYEIwGbPo1CiO09+jc=
Message-ID: <6bffcb0e0608200630h40d2b07v1db22d19753734be@mail.gmail.com>
Date: Sun, 20 Aug 2006 15:30:30 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm2
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20060819220008.843d2f64.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060819220008.843d2f64.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/
>

0kB Cache?

hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)

It should be 2048kB

Aug 20 14:28:07 euridica kernel: hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW
drive, 2048kB Cache, UDMA(33)
Aug 20 14:28:07 euridica kernel: Uniform CD-ROM driver Revision: 3.20
Aug 20 14:28:07 euridica kernel: hdd: ATAPI 52X CD-ROM CD-R/RW drive,
2048kB Cache, UDMA(33)

config & dmesg -> http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm2/

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
