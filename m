Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136407AbRD2WsH>; Sun, 29 Apr 2001 18:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136406AbRD2Wr4>; Sun, 29 Apr 2001 18:47:56 -0400
Received: from p3EE3CBEA.dip.t-dialin.net ([62.227.203.234]:19976 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S136404AbRD2Wrs>; Sun, 29 Apr 2001 18:47:48 -0400
Date: Mon, 30 Apr 2001 00:47:43 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Message-ID: <20010430004743.A5613@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010429122546.A1419@werewolf.able.es> <PGEDKPCOHCLFJBPJPLNMCEDOCMAA.denali@sunflower.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <PGEDKPCOHCLFJBPJPLNMCEDOCMAA.denali@sunflower.com>; from denali@sunflower.com on Sun, Apr 29, 2001 at 11:17:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Apr 2001, Steve 'Denali' McKnelly wrote:

> 	Let me ask a possibly stupid question... How do you tell
> what version of the Gibbs Adaptec driver you're using?  Did I
> misunderstand you when you said the 2.4.4 kernel is using 6.1.5?
> Also, did I understand you to say the 6.1.12 version will fix
> my unresolved symbol problem?

Try: dmesg | grep -i aic7xxx

Some distributions store the boot dmesg output in a file, since if the
kernel spews a lot of messages, the older ones get lost if the buffer is
full; SuSE e. g. have been using /var/log/boot.msg for quite some time
now.

Other systems throw the entire boot message output into the normal
syslog.  (Seen than one on FreeBSD 4.3, but I don't remember Debian 1.x
and Red Hat 6.0 Sparc.)
