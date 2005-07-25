Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVGYUG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVGYUG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVGYUEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:04:35 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:30438 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261516AbVGYUED convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:04:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rSh1QYhAo5YMZ+lmaGhJbxKDgAKmiaBEhM17qlCLJ6URlSI+xGnru+DyNgt+XZWtle5WgQMK1ArRnz0ACCF0Npv/2CVT71Tdn/xPBBFYJ95FPOwuNAFIlKYKl/Rjm8gnFhzy3uBn6Ln7cV5aL4tmzLt04DBT5OlOnD2AfzGAOBM=
Message-ID: <d120d500050725130341b069dc@mail.gmail.com>
Date: Mon, 25 Jul 2005 15:03:55 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andreas Baer <lnx1@gmx.net>
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood-
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       pmarques@grupopie.com
In-Reply-To: <42E542D5.3080905@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local>
	 <42E4E4B0.6050904@gmx.net> <20050725152425.GA24568@alpha.home.local>
	 <42E542D5.3080905@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/05, Andreas Baer <lnx1@gmx.net> wrote:
> 
> >>
> >>Here I have
> >>
> >>         /dev/hda:  26.91 MB/sec
> >>         /dev/hda1: 26.90 MB/sec    (Windows FAT32)
> >>         /dev/hda7: 17.89 MB/sec    (Linux EXT3)
> >>
> >>Could you give me a reason how this is possible?
> >
> >
> > a reason for what ? the fact that the notebook performs faster than the
> > desktop while slower on I/O ?
> 
> No, a reason why the partition with Linux (ReiserFS or Ext3) is always slower
> than the Windows partition?
> 

Because of geometry issues hard drive can't not deliver constant data
rate off the plates. Your windows partition is on "faster" part of the
drive.

-- 
Dmitry
