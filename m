Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbSLTEUP>; Thu, 19 Dec 2002 23:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbSLTEUP>; Thu, 19 Dec 2002 23:20:15 -0500
Received: from fluent2.pyramid.net ([206.100.220.213]:38277 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP
	id <S265939AbSLTEUO>; Thu, 19 Dec 2002 23:20:14 -0500
Message-Id: <5.2.0.9.0.20021219202414.01d5dae0@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 19 Dec 2002 20:28:13 -0800
To: "plachninka" <plachninka@wp.pl>, <linux-kernel@vger.kernel.org>
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: Saving logs when system is started
In-Reply-To: <001601c2a731$84f0b9c0$110011ac@home.sitech.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:37 AM 12/19/02 +0100, plachninka wrote:
>Hi
>Simple question: is any possibility to save system logs on floppy or
>anywhere when system is started from ramdisk?
>I still have a problem with scsi_hostadapter module and i would like to see
>startup logs

1.  Add to the end of rc the commands to copy the logs to floppy or anywhere.
2.  Add to the end of inittab a call, using :once:, to a script to copy the 
logs to floppy or anywhere.
3.  Write a daemon that mirrors the logs from time to time to floppy or 
anywhere, lauched from inittab or from whatever launches your daemons.


-- 
The human mind treats a new idea the way the body treats a strange
protein:  it rejects it.  -- P. Medawar
This posting is for entertainment purposes only; it is not a legal opinion.

