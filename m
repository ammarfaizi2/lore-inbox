Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316751AbSEWOox>; Thu, 23 May 2002 10:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSEWOow>; Thu, 23 May 2002 10:44:52 -0400
Received: from mail3.cadvision.com ([207.228.64.48]:59915 "EHLO
	mail3.cadvision.com") by vger.kernel.org with ESMTP
	id <S316751AbSEWOov>; Thu, 23 May 2002 10:44:51 -0400
Message-ID: <001701c20269$67d48dc0$0100007f@localdomain.wni.com.wirelessnetworksinc.com>
From: "Herman Oosthuysen" <Herman@WirelessNetworksInc.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <3CEA7866.23557.390B7FFC@localhost> <20020523011144.GA4006@matchmail.com> <20020523094948.A2462@redhat.com>
Subject: Re: 2.2 kernel - Ext3 & Raid patches
Date: Thu, 23 May 2002 08:52:04 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

Does this mean that Ext3 is still not recommended for use with RAID1?

Thanks,
--
Herman Oosthuysen
Herman@WirelessNetworksInc.com
Suite 300, #3016, 5th Ave NE,
Calgary, Alberta, T2A 6K4, Canada
Phone: (403) 569-5687, Fax: (403) 235-3965
----- Original Message -----
From: Stephen C. Tweedie <sct@redhat.com>
To: Jon Hedlund <JH_ML@invtools.com>; <sct@redhat.com>; <akpm@zip.com.au>;
<linux-kernel@vger.kernel.org>
Sent: Thursday, May 23, 2002 2:49 AM
Subject: Re: 2.2 kernel - Ext3 & Raid patches


> Hi,
>
> On Wed, May 22, 2002 at 06:11:44PM -0700, Mike Fedyk wrote:
> > On Tue, May 21, 2002 at 04:40:06PM -0500, Jon Hedlund wrote:
> > > 2. What is the "proper" fix for the patch collision between the raid
> > > patch and the ext3 patch in /include/linux/fs.h?
> >
> > Use 2.4.
>
> Actually, you just need to renumber one of the conflicting #defines to
> something unused, and it will work fine.  Soft raid0 or linear mode
> will work quite happily with ext3 on 2.2 after you do that, it's only
> the resync after a crash that you get with raid1 or raid5 that is
> dangerous.
>
> Cheers,
>  Stephen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

