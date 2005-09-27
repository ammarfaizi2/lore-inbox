Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVI0Jjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVI0Jjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 05:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVI0Jjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 05:39:36 -0400
Received: from web51010.mail.yahoo.com ([206.190.39.129]:5981 "HELO
	web51010.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964883AbVI0Jjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 05:39:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QlGyhVUPjHVkUN4VC0tmnu8h92qdaI5Z3FFElz09xnhz1iTDI33vlpFk+KuxbpBtokV6d+z0adLIjrBm5vCzGW6aP3QtdZ5h0BTSvRqAGS6aUDIQcfU5eNduo05ZVNUIkE/27EDqBIuhryEOYSb+grn2jeQWaxJhNJL8NgcXivM=  ;
Message-ID: <20050927093929.83645.qmail@web51010.mail.yahoo.com>
Date: Tue, 27 Sep 2005 02:39:29 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: [ANNOUNCE] Framework for automatic Configuration of a Kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

For my EndThesis, in the Niederrhein University of
Applied Sciences, I've almost finished a framework
that generates a .config file based on the target
system.This program should help people to generate a
linux kernel Config without spending a lot of time at
the configuration.

The basic idea of the framework is, that you can
specify in the Kconfig files a script which
auto-detect if the hardware involved in this option is
present or not (the script reply 'y' or 'n'). It's up
to the interface to choose what to do with the answer.

This framework is now in its test stage. It works on
my Acer Laptop(TM291LMI with Pentium M and Radeon
9700). That means, that the framework is functional
but additional scripts have to be written for other
type
of hardware/functionality (far away from completed).

The code of this framework has been in a Kernel-Patch.
Since the Patch has a huge size(230kb), you can get
the Patch from the given URL:

http://www.energyparty.de/ahmad/autoconfig_0_4.patch

To try it, just patch a 2.6.13 kernel with the patches
following this
mail and set the scripts as follow: chmod u+rwx
scripts/kconfig/rules/*
Then, just type: 'make autoconfig' or 'make
autochoiceconfig'.

The 'autoconfig' will detect your hardware and
automatically include in the kernel(as a biuld-in)
whatever hardware is detected. The 'autochoiceconfig'
will let you choose to include the feature or not when
a hardware is detected.

Any comments and suggestions are welcome !


Regards
Ahmad Reza Cheraghi



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
