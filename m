Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272455AbTHEGmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 02:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272456AbTHEGmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 02:42:31 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:15369 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S272455AbTHEGma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 02:42:30 -0400
Message-Id: <200308050632.h756W5j17568@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: William Lee Irwin III <wli@holomorphy.com>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
Subject: Re: .config in bzImage ?
Date: Tue, 5 Aug 2003 09:41:35 +0300
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20030802192957.GC32488@holomorphy.com> <E19j2sd-0003VB-00@calista.inka.de> <20030802202803.GD32488@holomorphy.com>
In-Reply-To: <20030802202803.GD32488@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 August 2003 23:28, William Lee Irwin III wrote:
> In article <20030802192957.GC32488@holomorphy.com> you wrote:
> >> IIRC this hit current 2.6 bk recently, which probably helps _someone_
> >> with administration (and may very well save me some reboots to get into
> >> kernels with known .configs).
> 
> On Sat, Aug 02, 2003 at 10:21:31PM +0200, Bernd Eckenfels wrote:
> > Of course you can simply place the .config along the kernel and the
> > System.map in /boot, too.
> 
> Which requires having some way to associate the running kernel to those
> files.

bash-2.03# ls -l /boot
drwxr-xr-x    2 root     root         1024 Jan 28  2003 2.4.20
drwxr-xr-x    2 root     root         1024 Nov  2  2002 2.4.20-pre11csum_t
drwxr-xr-x    2 root     root         1024 Oct 30  2002 2.4.20-pre11csumtest
drwxr-xr-x    2 root     root         1024 Jul 17 08:10 2.4.21
drwxr-xr-x    2 root     root         1024 Jul 17 15:15 2.4.21-ep

--
vda
