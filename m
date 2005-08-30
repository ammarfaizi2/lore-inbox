Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbVH3Vb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVH3Vb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 17:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVH3VbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 17:31:25 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:23771 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S932481AbVH3VbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 17:31:25 -0400
Date: Tue, 30 Aug 2005 23:31:13 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: LSM root_plug module questions
Message-ID: <20050830213112.GA28997@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently playing around with the security/root_plug.c LSM module 
and I have two questions:

1) What's the recommended way of telling that someone is logging in to 
the computer (via ssh, virtual console, serial console, X, whatever) 
with LSM? Look for open() on /dev/pts?

2) root_plug currently scans the usb device tree looking for the 
appropriate device each time it's needed. In the interest of making the 
result of the lookup cached, it is possible for a module to register so 
that it is notified when a usb device is added/removed?

Regards,
David

