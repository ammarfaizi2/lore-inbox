Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVFURgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVFURgT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVFURgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:36:19 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:26313 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262206AbVFURgH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:36:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AF131VYYyEs8uZdetO7TBRk4h9pV6s0qIMCpxDsO3epr8Q+oeYbqXYThiQMpzfOsw8IviglyIYJ6OCpMqWJ/kq7lBGWfh9v1gKpqS490mfB8AEIbzfo4m/SCUgC5M/7ziqLhZD0PvrAyZcWV8h5g46Ohdv6L5/6fizK1ER91RS4=
Message-ID: <5c77e70705062110353f180d70@mail.gmail.com>
Date: Tue, 21 Jun 2005 19:35:21 +0200
From: Carsten Otte <cotte.de@gmail.com>
Reply-To: Carsten Otte <cotte.de@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <20050621062926.GB15062@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050621062926.GB15062@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, Greg KH <gregkh@suse.de> wrote:
>  drivers/s390/block/dasd.c                         |    4
>  drivers/s390/block/dasd_genhd.c                   |    2
>  drivers/s390/block/dasd_int.h                     |    1
>  drivers/s390/block/xpram.c                        |    6
>  drivers/s390/char/monreader.c                     |    1
>  drivers/s390/char/tty3270.c                       |    3
>  drivers/s390/crypto/z90main.c                     |    1
>  drivers/s390/net/ctctty.c                         |    2
As for our drivers, I don't see any breakage on reading the patches.
If it gets merged,
we should make sure to try it once before next release.
