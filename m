Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSFFC6M>; Wed, 5 Jun 2002 22:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSFFC6L>; Wed, 5 Jun 2002 22:58:11 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:275 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S316747AbSFFC6K>;
	Wed, 5 Jun 2002 22:58:10 -0400
Message-Id: <200206060254.g562sa935892@aslan.scsiguy.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/scsi/aic7xxx/? considered harmful (2.4.19-pre9) 
In-Reply-To: Your message of "Thu, 06 Jun 2002 09:58:24 +1000."
             <15614.42400.697670.602385@notabene.cse.unsw.edu.au> 
Date: Wed, 05 Jun 2002 20:54:36 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hi,
> I have 3 NFS servers with ext3 on raid5 on scsi with assorted
>aic7xxx scsi controllers, all running 2.4.19-pre9 (plus some ext3 and
>raid and nfs patches) using the "new" aic7xxx drivers.

You need to use aic7xxx driver version 6.2.8 to avoid this problem.
Its been in Marcelo's tree for a bit, but I guess it missed pre9.

--
Justin
