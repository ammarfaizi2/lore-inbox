Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317322AbSFHJnI>; Sat, 8 Jun 2002 05:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317390AbSFHJnH>; Sat, 8 Jun 2002 05:43:07 -0400
Received: from fysh.org ([212.47.68.126]:31921 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S317322AbSFHJnG>;
	Sat, 8 Jun 2002 05:43:06 -0400
Date: Sat, 8 Jun 2002 10:43:07 +0100
From: Athanasius <link@gurus.tf>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: kernel: request_module[net-pf-10]: fork failed, errno 11
Message-ID: <20020608094307.GA6522@miggy.org.uk>
Mail-Followup-To: Athanasius <link@gurus.tf>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm seeing a lot of:

	kernel: request_module[net-pf-10]: fork failed, errno 11

in syslog, despite the fact I a) I have no IPv6 compiled in the kernel,
and b) have "alias net-pf-10 off             # IPv6" in
/etc/modules.conf.
  This is using a stock 2.4.18 kernel.  I was under the impression that
the /etc/modules.conf line would lead to such things as above not
happening.  Is the network code doing something slightly askew with
modules?

thanks,

-Ath
-- 
- Athanasius = Athanasius(at)miggy.org.uk / http://www.clan-lovely.org/~athan/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
