Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVE3PZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVE3PZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 11:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVE3PZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 11:25:44 -0400
Received: from web32806.mail.mud.yahoo.com ([68.142.206.36]:57203 "HELO
	web32806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261532AbVE3PZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 11:25:39 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=3E/S4FBuTm2Vpf+Bs0xR0HjsyJ9xU+JmyAGJ/R4xmAu6s8qHmVTdXlSwGid90wA+x+EfbD0mR+0yL6EgXp5uI82KJBVbC1NASioQzkWQRahfWJVofWfpMW5UROnX6+NY7D/YV7KRvjnYApuLKW0jSneMa6NcFt33lNR5BO6eZIg=  ;
Message-ID: <20050530152534.21912.qmail@web32806.mail.mud.yahoo.com>
Date: Mon, 30 May 2005 08:25:34 -0700 (PDT)
From: jayush luniya <jayu_11@yahoo.com>
Subject: HOTPLUG CPU Support for SMT
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been looking at the CONFIG_HOTPLUG_CPU option
in the Linux Kernel. The option works for IA64, PPP64,
S390 architectures. I am doing my research on SMT
architecture and want to write a kernel module that
can dynamically enable/disable SMT, so that I can
switch between uniprocessor mode and SMT mode. So is
it possible to use the CONFIG_HOTPLUG_CPU option to
dynamically enable/disable a logical processor by
performing a logical removal of the CPU since the
hardware does not support CPU hotplugging? Also I
would like to know how efficient such an
implementation would be? 

I would really appreciate if anyone could provide me
suggestions and any specific patches related to this
work.

Regards,
Jayush.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
