Return-Path: <linux-kernel-owner+w=401wt.eu-S932351AbXARNmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbXARNmP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbXARNmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:42:15 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:60746 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932351AbXARNmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:42:14 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IsNVQ2krKdi/b4+uE5ahOL9jtP7vU4Z810EwwHpLorv+5aNK728qY4bflgOHVlDRM5RCCSq5htGvWOiIwWgCHkf7I5+LLhNZ9jM8wW3xsKLD7jezqxitZnVZYoEyfT9mkawn6B/D1ian6unG+Wd17eu7GWpVwh5TmJ9pX+7G410=
Message-ID: <c951f21e0701180542v22ce9ebaw69c36a1b2084daaa@mail.gmail.com>
Date: Thu, 18 Jan 2007 14:42:13 +0100
From: "Daniel Gonzalez Schiller" <daniel.schiller@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.19 bug report --> "atkbd.c:spurious ACK on isa...." when boot from SATA hd, no way to start system
In-Reply-To: <c951f21e0701180539t623387edh5783abc795ea3c9f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c951f21e0701180539t623387edh5783abc795ea3c9f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When boot with SATA HD --> "atkbd.c:spurious ACK on isa0060/serio0. Some
program might be trying access hardware directly."

When booting with normal hd no problem.

I've searched in changelog but nothing found.

more people with this problem:
http://iansblog.jandi.co.nz/2006/10/catching-upbleeding-edge.html
 http://www.linuxquestions.org/questions/showthread.php?t=507224


I use:
Debian unstable linux Kernel 2.6.19
on a duron1200 with ata drives and one sata-hd

I have got ATA DEVICE SUPPORT AS A MODULE IN the Kernel .CONFIG

my system:

K7VT4A Pro
SATA:
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80)

Modules:
  sata_via
  libsata

cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 7
model name      : AMD Duron(tm)
stepping        : 1
cpu MHz         : 1198.859
cache size      : 64 KB

no patches, no fixes in kernel
