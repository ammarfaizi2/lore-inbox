Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWEORsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWEORsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWEORsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:48:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:47528 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965016AbWEORsQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:48:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r8Dupdqtg5YkivUId+6pwIyf1zZMUYD1IB578rwf/6SYz9HWM3bIKBaqztZiW6nUy+SJBsvBPdpPJrOR/537/VD/oGZE5q97h/LJZCg7xUiPbYDVH/6eW6HgnK8D7OUkwCzfj6DQewofKqdIeEDhavHOhjwyOKYgtmtDnV/XpVM=
Message-ID: <6bffcb0e0605151048r314132cdvedf7c33b3c945c72@mail.gmail.com>
Date: Mon, 15 May 2006 19:48:15 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060515005637.00b54560.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/05/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm1/
>
> - This tree contains a large number of new bugs^H^H^H^Hpatches.
>
[snip]
> +kbuild-export-symbol-usage-report-generator.patch

When I try make exportcheck with O=/dir I get this error
[michal@ltg01-fedora linux-mm]$ make O=../linux-mm-obj/ exportcheck
EXPORTFILE=../linux-mm-obj/export.dat
  Using /usr/src/linux-mm as source for kernel
[..]
Can't open perl script
"/usr/src/linux-mm-obj/scripts/export_report.pl": No such file or
directory
make[2]: *** [__modpost] Error 2
make[1]: *** [modules] Error 2
make: *** [exportcheck] Error 2

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
