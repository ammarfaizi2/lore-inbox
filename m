Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317342AbSFMJ5a>; Thu, 13 Jun 2002 05:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317389AbSFMJ53>; Thu, 13 Jun 2002 05:57:29 -0400
Received: from dionis.mirotel.net ([194.125.225.7]:2275 "EHLO
	dionis.mirotel.net") by vger.kernel.org with ESMTP
	id <S317342AbSFMJ51>; Thu, 13 Jun 2002 05:57:27 -0400
Date: Thu, 13 Jun 2002 12:57:01 +0300 (EEST)
From: Remedy <remedy@dionis.mirotel.net>
To: Padraig Brady <padraig@antefacto.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: net sysctls questions
In-Reply-To: <3D06051C.3030305@antefacto.com>
Message-ID: <Pine.LNX.4.33.0206131250400.7091-100000@dionis.mirotel.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002, Padraig Brady wrote:

> The net.ipv4.icmp_default_ttl patch
> reminds me, about wierd stuff I've
> seen in the net sysctls:
Sorry, english is not my native language so i was unable to interpret
"wierd" :)
>
> /proc/sys/net/unix/max_dgram_qlen is only
> readable by root. Why?
Check your /proc been mounted as read-write.

on my machine:
fortress ~# sysctl -w net.unix.max_dgram_qlen=20;
net.unix.max_dgram_qlen = 20
fortress ~# sysctl -w net.unix.max_dgram_qlen=10;
net.unix.max_dgram_qlen = 10

--
Software engineer			Mirotel ISP


