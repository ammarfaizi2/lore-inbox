Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280481AbRKNMCD>; Wed, 14 Nov 2001 07:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280502AbRKNMBy>; Wed, 14 Nov 2001 07:01:54 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:15112 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280496AbRKNMBl>; Wed, 14 Nov 2001 07:01:41 -0500
Date: Wed, 14 Nov 2001 13:01:36 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Donald Harter <dharter@lycos.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Is this a kernel problem? segmentation fault
In-Reply-To: <IPKBFBEEDJJJACAA@mailcity.com>
Message-ID: <Pine.LNX.4.33.0111141257430.9909-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 13 Nov 2001, Donald Harter wrote:

> Using gdb I was able to disassemble the instructions at the called
> address. Why can gdb disasemble instructions at a call address and a
> call to that address fails with a segmentation fault?

Check the memory protection settings in /proc/[pid]/maps, when gdb
accesses that memory with ptrace these settings are ignored.

bye, Roman


