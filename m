Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbSIZM62>; Thu, 26 Sep 2002 08:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSIZM62>; Thu, 26 Sep 2002 08:58:28 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:65298 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261323AbSIZM61>; Thu, 26 Sep 2002 08:58:27 -0400
Message-Id: <200209261258.g8QCwpp04301@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Marco Schwarz <marco.schwarz@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Serious Problems with diskless clients
Date: Thu, 26 Sep 2002 15:53:08 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020926095957.GC42048@niksula.cs.hut.fi> <3489.1033036000@www51.gmx.net>
In-Reply-To: <3489.1033036000@www51.gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 September 2002 08:26, Marco Schwarz wrote:
> Hi all,
>
> my diskless clients have some severe problems on one of my servers.
> Sometimes (right now most of the time) everything just hangs at the same
> place when starting up the kernel. Here are the last messages I get (right
> before this IP-Config is running and looks OK):
>
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0
> ds: no socket drivers loaded !
> Looking up port of RPC 100003/2 on 192.168.0.235
> portmap: server 192.168.0.235 mot responding, timed out !

Hook another box to the same network segment and run
ping or mtr to 192.168.0.235 and to the booting box.
Maybe your net drops packets or otherwise misbehaves.

BTW, 2.4.10 is way too old. 
I don't see "mot responding, timed out !" in 2.4.19
source, rather "not responding, timed out".
--
vda
