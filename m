Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287488AbSAQBEg>; Wed, 16 Jan 2002 20:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287490AbSAQBE1>; Wed, 16 Jan 2002 20:04:27 -0500
Received: from chiark.greenend.org.uk ([212.22.195.2]:13060 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S287488AbSAQBEV>; Wed, 16 Jan 2002 20:04:21 -0500
Date: Thu, 17 Jan 2002 01:04:20 +0000
From: Andrew Kanaber <akanaber@chiark.greenend.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] cs46xx: sound distortion after hours of use
Message-ID: <20020117010420.B31976@chiark.greenend.org.uk>
In-Reply-To: <200201151224.g0FCO8E06163@Port.imtp.ilyichevsk.odessa.ua> <3C449426.6000300@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <3C449426.6000300@us.ibm.com>; from haveblue@us.ibm.com on Tue, Jan 15, 2002 at 09:32:01PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 09:32:01PM +0000, David C. Hansen wrote:
> BTW, I have a Thinkpad T21.  Do any of you have a non-IBM notebook?

I have a non-IBM non-notebook apparently with this problem. It's an Athlon
XP/Via KT266A desktop system with a Turtle Beach Santa Cruz soundcard,
running kernel 2.4.17 with cs46xx as a module and APM compiled in. Sound
became very distorted playing MP3s, rmmod cs46xx followed by modprobe cs46xx
fixed the problem. It's only happened once so far, but I've only had this
machine for two weeks.

I'm afraid cat /proc/apm doesn't seem to reproduce the problem for me
either.

Andrew
