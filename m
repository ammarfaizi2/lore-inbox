Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbTB1GaC>; Fri, 28 Feb 2003 01:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTB1GaC>; Fri, 28 Feb 2003 01:30:02 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:21254 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267545AbTB1GaB>; Fri, 28 Feb 2003 01:30:01 -0500
Message-Id: <200302280619.h1S6IXs32638@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Kasper Dupont <kasperd@daimi.au.dk>
Subject: Re: About /etc/mtab and /proc/mounts
Date: Fri, 28 Feb 2003 08:15:07 +0200
X-Mailer: KMail [version 1.3.2]
Cc: jw schultz <jw@pegasys.ws>, Linux-kernel <linux-kernel@vger.kernel.org>
References: <20030219112111.GD130@DervishD> <200302271251.h1RCpas29798@Port.imtp.ilyichevsk.odessa.ua> <3E5E9F2F.532CB774@daimi.au.dk>
In-Reply-To: <3E5E9F2F.532CB774@daimi.au.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 February 2003 01:28, Kasper Dupont wrote:
> Denis Vlasenko wrote:
> > lrwxrwxrwx   1 root     root           12 Nov 12  2001 root ->
> > /.share/root
>
> Wouldn't it be best to keep /root on the root filesystem?
> It is rarely large, and if you need to log in as root to
> fix some mounting problem, I guess you want your home
> directory.

No. My rootfs is RO. My home dir shouldn't be.

> > lrwxrwxrwx   1 root     root           11 Nov 12  2001 mnt ->
> > /.local/mnt
>
> What is the point in making mnt a local directory? All
> it contains are some directories to serve as mountpoints.
> I guess you are going to mount something on top of every
> subdirectory in mnt anyway.

Yes.
--
vda
