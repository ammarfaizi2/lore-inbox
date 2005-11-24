Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbVKXV6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbVKXV6c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 16:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbVKXV6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 16:58:31 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:20186 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1161050AbVKXV6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 16:58:31 -0500
Date: Thu, 24 Nov 2005 22:58:06 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: swsusp resume from dm-crypt over lvm?
Message-ID: <20051124215806.GA8086@hardeman.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-SA-Score: -2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the ability to echo the major:minor to /sys/power/resume from an 
initramfs script I am able to resume from a lvm partition.

However, this doesn't seem to work if the swap partition is encrypted 
and setup using cryptsetup (dm-crypt over an lvm partition that is).

Is this supposed to work or is it not feasible?

Re,
David

Please CC any replies...
