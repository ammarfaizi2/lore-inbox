Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbRFAUjA>; Fri, 1 Jun 2001 16:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbRFAUiv>; Fri, 1 Jun 2001 16:38:51 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:47609 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S261493AbRFAUii>; Fri, 1 Jun 2001 16:38:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Subject: Re: missing sysrq
Date: Fri, 1 Jun 2001 22:52:58 +0200
X-Mailer: KMail [version 1.2.2]
In-Reply-To: <Pine.LNX.4.10.10106011050380.2614-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10106011050380.2614-100000@coffee.psychology.mcmaster.ca>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010601203841Z261493-933+3160@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 1. Juni 2001 16:51 schrieben Sie:
> > Have you tried "echo 1 > /proc/sys/kernel/sysrq"?
> > You need both, compiled in and activation.
>
> no, look at the code.  the enable variable defaults to 1.

Then there must be a bug?
I get "0" with 2.4.5-ac2 and -ac5 without "echo 1".

Fresh booted 2.4.5-ac2:

SunWave1>cat /proc/version
Linux version 2.4.5-ac2 (root@SunWave1) (gcc version 2.95.2 19991024 
(release)) #1 Mon May 28 05:42:09 CEST 2001
SunWave1>cat /proc/sys/kernel/sysrq
0

-Dieter
