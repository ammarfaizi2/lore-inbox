Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316773AbSF0Jjj>; Thu, 27 Jun 2002 05:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316763AbSF0Jji>; Thu, 27 Jun 2002 05:39:38 -0400
Received: from mail.webmaster.com ([216.152.64.131]:8381 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S316759AbSF0Jji> convert rfc822-to-8bit; Thu, 27 Jun 2002 05:39:38 -0400
From: David Schwartz <davids@webmaster.com>
To: <Gregoryg@ParadigmGeo.com>,
       Linux Kernel (E-mail) <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Thu, 27 Jun 2002 02:39:37 -0700
In-Reply-To: <EE83E551E08D1D43AD52D50B9F511092E11409@ntserver2>
Subject: Re: Multiple profiles
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020627093938.AAA4576@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Jun 2002 11:30:03 +0200, Gregory Giguashvili wrote:

>Hello,
>
>I wonder if somebody is familiar with the way to create multiple hardware
>configurations (profiles) on Linux? This is required, for instance, when
>booting laptop not connected to the network.
>
>Thanks in advance,
>Giga

	There is no way to create multiple profiles on Linux. But there may be a way 
on particular distributions or installations. Multiple hardware 
configurations mostly have to do with:

	1) What kernel gets loaded.

	2) What initial root disk is used.

	3) What modules are loaded.

	4) What configuration scripts are run, how they setup hardware during the 
bootup process, and so on.

	All of these things are handled by things that vary from Linux machine to 
Linux machine. How you choose which kernel to boot depends upon your boot 
manager. How your configuration scripts work depends upon how those scripts 
are constructed.

	DS


