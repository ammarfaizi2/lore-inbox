Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132433AbRDEBZD>; Wed, 4 Apr 2001 21:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132508AbRDEBYx>; Wed, 4 Apr 2001 21:24:53 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:7946 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132433AbRDEBYm>; Wed, 4 Apr 2001 21:24:42 -0400
Message-ID: <3ACBC91B.8224A379@baldauf.org>
Date: Thu, 05 Apr 2001 03:23:39 +0200
From: Xuan Baldauf <xuan--reiserfs@baldauf.org>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Nicholas Petreley <nicholas@petreley.com>,
        Harald Dunkel <harri@synopsys.COM>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS? How reliable is it? Is this the future?
In-Reply-To: <E14kyLV-0003AB-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

> > This is a reiserfs security issue, but only of theoretical nature (Even i=
> > f
> > triggered, it won't harm you). But the reason for this bug is in NFS (v2,=
>
> If the blocks contained my old /etc/shadow I'd be a bit upset.

The only bad consequence possible is that you possibly cannot create a file with
a given filename if someone else (remote user) could create at least 127 files
with a very special filename within the same directory. Usually, /etc/shadow and
all other important files either are created before any other user has access or
(if they are created later) belong to directories where only root may create
files in it.

>
>
> > displacement instead of vertical displacement) is planned.
> >
> > I can tell you more if you want.
>
> I trust Chris to keep it in order. I've not yet had a broken patch from them
> for -ac

:-)


