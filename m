Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315429AbSELVjU>; Sun, 12 May 2002 17:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSELVjT>; Sun, 12 May 2002 17:39:19 -0400
Received: from mail5.svr.pol.co.uk ([195.92.193.20]:10000 "EHLO
	mail5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S315429AbSELVjS>; Sun, 12 May 2002 17:39:18 -0400
Date: Sun, 12 May 2002 22:42:18 +0100
From: Stig Brautaset <stigbrau@start.no>
To: linux-kernel@vger.kernel.org
Subject: xircom nic itch (drops ip)
Message-ID: <20020512214217.GA19727@brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-URL: http://www.brautaset.org
X-Location: London, UK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

My pcmcia network card drops its ip from time to time. This happens
frequently enough for it to be rather annoying, but not frequently to be
really annoying. It seems to happen when there is no traffic through
the link (based on the fact that I cannot ever remember it happening
while I was on irc ;).

When the problem first occurs, it seems to occur several times quickly
one after another a few times, then the problem goes away. There is no
problem with suspend/resume, however.

I am unable to find anything in any of the logs, and bugs.debian.org
does not list any related bugs for the pcmcia-cs or hotplug scripts.

The card is a Xircom Cardbus 10/100 NIC (CBEM56G-100), and it use the
kernel's xircom_cb module. I used to use the module in the pcmcia_cs
package before, but I can't remember whether it was any better then (I
don't think it was though).

$ uname -a 
Linux arwen 2.4.18 #1 Tue Apr 9 02:05:16 BST 2002 i686 unknown

Stig
-- 
brautaset.org
