Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSFITAq>; Sun, 9 Jun 2002 15:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSFITAp>; Sun, 9 Jun 2002 15:00:45 -0400
Received: from p50887457.dip.t-dialin.net ([80.136.116.87]:49826 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314551AbSFITAo>; Sun, 9 Jun 2002 15:00:44 -0400
Date: Sun, 9 Jun 2002 13:00:05 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Dave Jones <davej@suse.de>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        <linux-kernel@vger.kernel.org>, <chaffee@cs.berkeley.edu>
Subject: Re: [patch] fat/msdos/vfat crud removal
In-Reply-To: <m18z5owd9f.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0206091257340.8715-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9 Jun 2002, Eric W. Biederman wrote:
> #include <linux/*>
> and 
> #include <asm/*>
> are no longer supported.

Stop! The reason for _some_ includes there is actually to keep some 
definitions in sync with the kernel, e.g. errno values! Stopping them 
altogether is a Really Bad Thing[tm], IMO, since it means users will have 
to get a new glibc with almost every kernel they have (don't tell me we 
don't change much!).

I'm against it.

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

