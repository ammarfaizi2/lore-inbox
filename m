Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287373AbSBCQcA>; Sun, 3 Feb 2002 11:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287388AbSBCQbv>; Sun, 3 Feb 2002 11:31:51 -0500
Received: from [199.203.178.211] ([199.203.178.211]:23559 "EHLO
	exchange.store-age.com") by vger.kernel.org with ESMTP
	id <S287373AbSBCQbg>; Sun, 3 Feb 2002 11:31:36 -0500
Message-ID: <BDE817654148D51189AC00306E063AAE05461A@exchange.store-age.com>
From: Alexander Sandler <ASandler@store-age.com>
To: "'arjan@fenrus.demon.nl'" <arjan@fenrus.demon.nl>,
        Alexander Sandler <ASandler@store-age.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.17: Bug?
Date: Sun, 3 Feb 2002 18:31:07 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="x-user-defined"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's 4.27beta.
QLogic currently has three different drivers on their web site. This one is
the oldest and the most stable. With other two I wan't even able to those
LUNs.

One more thing I didn't tell. According to 'ps', stacked process is sleeping
in __get_request_wait() from ll_rw_blk.c

Alexandr Sandler.

> -----Original Message-----
> From: arjan@fenrus.demon.nl [mailto:arjan@fenrus.demon.nl]
> Sent: Sunday, February 03, 2002 4:27 PM
> To: ASandler@store-age.com
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.4.17: Bug?
> 
> 
> In article 
> <BDE817654148D51189AC00306E063AAE054619@exchange.store-age.com
> > you wrote:
> > Hi all.
> > The configuration is the following:
> > Dual CPU machine with Linux RedHat 7.1 running kernel 2.4.17 
> > (official), connected to SAN with two FC-HBAs (QLogic 2200).
> 
> which driver are you using for that ?
> 
