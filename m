Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWARJvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWARJvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 04:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWARJvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 04:51:44 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:54825 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751299AbWARJvn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 04:51:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h93d7QXzz6AcwK9rXinwfNPelcumknclNd8MAwDXJNV8kavS4Vw35EEeZiRvHcUyk04Jv3nLw6xZa3ZOxju4+D8HzlfpxwX6M9H6+3wJE79kJlG3JunyWkuVWVHOjvJXaI6+eTp6449tZDw6OdJzi19X3pQyfriIUa/uBAVsnkQ=
Message-ID: <58cb370e0601180151n4cb9a9cbyd05cef28c9483a89@mail.gmail.com>
Date: Wed, 18 Jan 2006 10:51:41 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Marcus Hartig <m.f.h@web.de>
Subject: Re: 2.6.15 libata/sata_sil: not detecting my SATA dvd-drive.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43CDE526.5060904@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43CDE526.5060904@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/06, Marcus Hartig <m.f.h@web.de> wrote:
>  > In kernel 2.6.13.4, I'm able to acces my dvd-drive by changing these
>  > lines in include/linux/libata.h
>
> Enable SATA ATAPI in drivers/scsi/libata-core.c now. Line 81 with
> 2.6.16-rc1:
>
> int atapi_enabled = 1;
>
> and recompile.

Jon said that he is using "libata.atapi_enabled=1"
kernel parameter so this shouldn't be needed.

Bartlomiej
