Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVLHUM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVLHUM3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVLHUM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:12:29 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:21809 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932288AbVLHUM2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:12:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B7aGMi/+C4LoadwK1RYvVl2O5/BNYMC1w6Z2uWszik+HdJTPlOJAIOH1vxFKNvVLYa9s7WQCJShtmAnM2s3je1+Z/0Y0h5Dl/eHuj44SeI3gOQh1QAuQA+/khWqgkQZp707iTmDw7i4QWQIr/M6TT7YPmC9AGh7Yk9WEp26Qxbc=
Message-ID: <58cb370e0512081212u55469c5es6d84d2c5d9e7fd06@mail.gmail.com>
Date: Thu, 8 Dec 2005 21:12:26 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: =?ISO-8859-1?Q?Sebastian_K=E4rgel?= <mailing@wodkahexe.de>
Subject: Re: 2.6.{14,15-rc4} harddrive cache not detected
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051208202337.e3798191.mailing@wodkahexe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20051208194408.77e17f64.mailing@wodkahexe.de>
	 <58cb370e0512081105x68e855e4n98312b1f3a25abab@mail.gmail.com>
	 <20051208202337.e3798191.mailing@wodkahexe.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/05, Sebastian Kärgel <mailing@wodkahexe.de> wrote:
> On Thu, 8 Dec 2005 20:05:37 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> > I think that I've seen before some other Toshiba
> > disks that incorrectly report cache size.
> >
> > Could you send /proc/ide/hda/identify?
>
> Hello,
>
> # cat /proc/ide/hda/identify

> 007e 0000 7c6b 5908 4003 7c69 1808 4003

write-cache is enabled so disk just doesn't report the size
of the cache, as noted by Alan - no need to worry :)

Bartlomiej
