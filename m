Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbTBGXgS>; Fri, 7 Feb 2003 18:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbTBGXgS>; Fri, 7 Feb 2003 18:36:18 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:38667 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266851AbTBGXgR>; Fri, 7 Feb 2003 18:36:17 -0500
Date: Sat, 8 Feb 2003 00:45:46 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org, <torvalds@transmeta.com>
Subject: Re: [PATCH] kill i_cdev and struct char_device
In-Reply-To: <UTC200302072317.h17NHbZ08117.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0302080041590.32518-100000@serv>
References: <UTC200302072317.h17NHbZ08117.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 8 Feb 2003 Andries.Brouwer@cwi.nl wrote:

> [the whole purpose of struct block_device is to provide the link
> between a device number and a struct block_device_operations.
> struct char_device has no such function, indeed, no function at all]

Why do you think, the same shouldn't be done for char_device?
You are removing the wrong infrastructure, check how block_dev.c changed 
between 2.4 and 2.5 and the same still needs to be done for char_dev.c.

bye, Roman

