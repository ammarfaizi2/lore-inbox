Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272672AbTHEL4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 07:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272676AbTHEL4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 07:56:09 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:52747 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S272672AbTHEL4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 07:56:08 -0400
Message-Id: <200308051145.h75BjEj19042@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: .config in bzImage ?
Date: Tue, 5 Aug 2003 14:54:45 +0300
X-Mailer: KMail [version 1.3.2]
Cc: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
References: <20030802192957.GC32488@holomorphy.com> <200308050632.h756W5j17568@Port.imtp.ilyichevsk.odessa.ua> <20030805064528.GR32488@holomorphy.com>
In-Reply-To: <20030805064528.GR32488@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 August 2003 09:45, William Lee Irwin III wrote:
> >> Which requires having some way to associate the running kernel to those
> >> files.
> 
> > bash-2.03# ls -l /boot
> > drwxr-xr-x    2 root     root         1024 Jan 28  2003 2.4.20
> > drwxr-xr-x    2 root     root         1024 Nov  2  2002 2.4.20-pre11csum_t
> > drwxr-xr-x    2 root     root         1024 Oct 30  2002 2.4.20-pre11csumtest
> > drwxr-xr-x    2 root     root         1024 Jul 17 08:10 2.4.21
> > drwxr-xr-x    2 root     root         1024 Jul 17 15:15 2.4.21-ep
> 
> Insufficient. That's what I do most of the time anyway; when I got
> burned it was with a batch of kernels I'd built simultaneously.

I never build kernels with same names.
Whenever I change .config, I change extraversion too.
--
vda
