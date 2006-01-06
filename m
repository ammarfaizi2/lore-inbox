Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752324AbWAFAj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbWAFAj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbWAFAj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:39:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932141AbWAFAj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:39:27 -0500
Date: Thu, 5 Jan 2006 16:39:22 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: command line parsing broken in 2.6.15-git?
Message-ID: <20060105163922.7806343b@dxpl.pdx.osdl.net>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The command line parsing or psmouse driver is broken now, this
makes my mouse go wacky on a KVM. It worked up until the latest
git updates (post 2.6.15)

Dmesg output:

Kernel command line: root=/dev/md2 vga=0x31a ro selinux=0 psmouse.proto=bare
Unknown boot option `psmouse.proto=bare': ignoring

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
