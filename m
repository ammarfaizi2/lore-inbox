Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290787AbSBLGA6>; Tue, 12 Feb 2002 01:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290785AbSBLGAt>; Tue, 12 Feb 2002 01:00:49 -0500
Received: from mail.webmaster.com ([216.152.64.131]:27328 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S290786AbSBLGAf> convert rfc822-to-8bit; Tue, 12 Feb 2002 01:00:35 -0500
From: David Schwartz <davids@webmaster.com>
To: <super.aorta@ntlworld.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Mon, 11 Feb 2002 22:00:32 -0800
In-Reply-To: <3C67AFD3.722C5471@ntlworld.com>
Subject: Re: faking time
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020212060033.AAA2067@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Feb 2002 11:49:39 +0000, SA products wrote:

>I want to fake the time returned by the time() system call so that for a
>limited number
>of user space programs the time can be set to the future or the past
>without affecting
>other applications and without affecting system time-- Ideally I would
>like to install a
>loadable module to accomplish this- Any hints ? Any starting points?

	If you're doing this to defeat a program's security or licensing scheme, let 
me warn you that there are many ways this could be detected. Inconsistencies 
in different time functions, filesystem times that are way ahead of system 
time, times built into networking protocols (and thus received from remote 
machines), detection of times before other run time, and so on.

	DS


