Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132501AbRDEBXB>; Wed, 4 Apr 2001 21:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132508AbRDEBWw>; Wed, 4 Apr 2001 21:22:52 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:30986 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132482AbRDEBWf> convert rfc822-to-8bit; Wed, 4 Apr 2001 21:22:35 -0400
Message-ID: <3ACBC4F4.C177E40A@baldauf.org>
Date: Thu, 05 Apr 2001 03:05:56 +0200
From: Xuan Baldauf <xuan--reiserfs@baldauf.org>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Nicholas Petreley <nicholas@petreley.com>,
        Harald Dunkel <harri@synopsys.COM>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS? How reliable is it? Is this the future?
In-Reply-To: <E14kU75-0008Qx-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

> > The bad (2.2 kernels)
> >
> > * Nothing I can think of
>
> Security exploit according to bugtraq, but Im pretty sure it wont take Chris
> Mason and friends long to fix that.
>

This is a reiserfs security issue, but only of theoretical nature (Even if
triggered, it won't harm you). But the reason for this bug is in NFS (v2, v3,
hopefully not also v4) readdir braindamage.

I think, in Reiser(FS)4, a more sophisticated (NFS-)work-around (horizontal
displacement instead of vertical displacement) is planned.

I can tell you more if you want.

Xuân.


