Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbTBLGZM>; Wed, 12 Feb 2003 01:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTBLGZM>; Wed, 12 Feb 2003 01:25:12 -0500
Received: from firewall.francoudi.net.32.27.217.in-addr.arpa ([217.27.32.7]:50428
	"EHLO news.linux.dom") by vger.kernel.org with ESMTP
	id <S266948AbTBLGZL>; Wed, 12 Feb 2003 01:25:11 -0500
To: linux-kernel@vger.kernel.org
From: Leonid Mamtchenkov <f.l.linux-admin@news.francoudi.com>
Subject: Re: start up script
Date: Wed, 12 Feb 2003 06:35:19 +0000 (UTC)
Organization: Thunderworx Ltd.
Message-ID: <b2cpv7$49p$2@news.linux.dom>
References: <200302111705.21190.unix@amigo.net.gt>
X-Trace: news.linux.dom 1045031719 4409 10.5.10.99 (12 Feb 2003 06:35:19 GMT)
X-Complaints-To: admins@news.francoudi.com
User-Agent: tin/1.5.15-20021115 ("Spiders") (UNIX) (Linux/2.4.18-19.8.0 (i686))
Reply-To: Leonid Mamtchenkov <leonid@francoudi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Luis - <unix@amigo.net.gt> wrote:
L> Hi all, i want to add a script to the start up in my Red Hat box, but i 
L> already put the file in /etc/rc.d/init.d and make the symbolic link in 
L> /etc/rc3.d/S55routetable.
L> 
L> But still doesn't work, if i run the script manually, it runs just fine, 
L> but when i restart the server i doesn't run.  

You might want to try using chkconfig(8) instead of manually creating
symlinks.

L> Basically the script is for adding some routes to my server.

You can add static routes by editing /etc/sysconfig/static-routes.  The
format of the file is 1 route definition per line.  Route definition
looks like:

eth0 net 10.5.10.0 netmask 255.255.255.0 gw 10.5.17.1

HTH.

-- 
Best regards,
  Leonid Mamtchenkov, RHCE
  System Administrator
  Francoudi & Stephanou Ltd.

