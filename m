Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129894AbQLTMdo>; Wed, 20 Dec 2000 07:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbQLTMde>; Wed, 20 Dec 2000 07:33:34 -0500
Received: from p3EE3C909.dip.t-dialin.net ([62.227.201.9]:46084 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129894AbQLTMd2> convert rfc822-to-8bit; Wed, 20 Dec 2000 07:33:28 -0500
Date: Wed, 20 Dec 2000 13:03:00 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.2.18] VM: do_try_to_free_pages failed
Message-ID: <20001220130259.A9659@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last night, one of your production machines got wedged, I caught a lot
of kernel: VM: do_try_to_free_pages failed for ... for a whole range of
processes, among them ypbind, klogd, syslogd, xntpd, cron, nscd, X,
master (Postfix super daemon), pvmd3, K applications and so on, I was
unable to log in via ssh, someone on-site has finally reset that machine
this noon to bring it back online.

How can I get rid of those do_try_to_free_pages lockups? That box
exports root file systems for some SparcStation 2 that are used as X
terminals, so it's pretty important I keep that box running.

Should I try the most recent 2.2.19-pre?

The machine is a pentium-MMX with 64 MB RAM with a kernel 2.2.18 that
has these patches/updated drivers (none VM related AFAICS):

IDE 2.2.18.1209
I²C 2.5.4
LM_Sensors 2.5.4
DC390 2.0e7
ReiserFS 3.5.28

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
