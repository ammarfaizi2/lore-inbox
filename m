Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270072AbTGNK7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 06:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270073AbTGNK7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 06:59:24 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:51218 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270072AbTGNK7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 06:59:23 -0400
Subject: Re: 2.6.0-test1: Hang during boot on Intel D865PERL motherboard
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <retes_simbad@yahoo.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030714110311.6059.qmail@linuxmail.org>
References: <20030714110311.6059.qmail@linuxmail.org>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1058181246.856.7.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 14 Jul 2003 13:14:08 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El lun, 14-07-2003 a las 13:03, Felipe Alfaro Solana escribió:
> Hi,
> 
> I've compiled linux-2.6.0-test1 kernel with the attached "config" file. When trying to boot the kernel, it hangs on "Uncompress Linux kernel...OK". The system is:

Hang or blank screen?

Known gotchas.
~~~~~~~~~~~~~~
Certain known bugs are being reported over and over. Here are the
workarounds.
- Blank screen after decompressing kernel?
  Make sure your .config has
  CONFIG_INPUT=y, CONFIG_VT=y, CONFIG_VGA_CONSOLE=y and CONFIG_VT_CONSOLE=y
  A lot of people have discovered that taking their .config from 2.4 and
  running make oldconfig to pick up new options leads to problems, notably
  with CONFIG_VT not being set. 
-- 
/================================================\
| Ramón Rey Vicente <ramon.rey at hispalinux.es> |
|                                                |
| Jabber ID <rreylinux at jabber.org>            |
|                                                |
| Public GPG Key http://pgp.escomposlinux.org    |
|                                                |
| GLiSa http://glisa.hispalinux.es               |
\================================================/

