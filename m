Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbULPOlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbULPOlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbULPOgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:36:49 -0500
Received: from web51502.mail.yahoo.com ([206.190.38.194]:3976 "HELO
	web51502.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262686AbULPOfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:35:40 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=JnLKS9f2spssjt3p8RwdPEztCwhpk10rOkqgIkKiravttS7TWC3WKAKrNY3I/lgLFcxdChv0npc1egQ0i1l8Lglf/cLX3GwSyTEHsh3YrSJhVNwxX690v6OFVUaaRUh+AKFYbqbU4mjAepoHZ0fFAZPZcRgrmP8orFqLlsbD9cY=  ;
Message-ID: <20041216143537.41770.qmail@web51502.mail.yahoo.com>
Date: Thu, 16 Dec 2004 06:35:37 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: What's the matter with build-in netconsole?
To: mpm@selenic.com
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I try to use netconsole to keep Linux kernel oops to
another machine. I've compiled netconsole into the
kernel (i.e. select CONFIG_NETCONSOLE=y, when run
'make menuconfig'). 
  After that, I put
"netconsole=@/,514@192.168.0.1/00:02:3F:03:D2:59"
(which is described in
/usr/src/linux/Documentation/networking/netconsole.txt)
to the kernel command line as provided by grub and
rerun my machine with the new compiled kernel.
  But then, when the system is booting, it shows the
following message:

... ...
Uncompressing Linux... Ok, booting the kernel.
audit(1103234064.4294965842:0): initialized
netconsole: eth0 doesn't exist, aborting.
... ...

  Then, What's the matter with the build-in
netconsole? Have I misconfiged the netconsole? and How
to really run build-in netconsole?

  Thank you.


=====
Best Regards,
Park Lee

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
