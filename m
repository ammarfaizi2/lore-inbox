Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWBSWJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWBSWJZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWBSWJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:09:24 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:36490 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751052AbWBSWJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:09:24 -0500
Message-ID: <55342.128.237.252.29.1140386963.squirrel@128.237.252.29>
Date: Sun, 19 Feb 2006 17:09:23 -0500 (EST)
Subject: tcp_protocol no longer exported? depracated?
From: "George P Nychis" <gnychis@cmu.edu>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a module from the 2.6.9 kernel that uses tcp_protocol which is no longer exported.  To use it I can EXPORT_SYMBOL(tcp_protocol) in ipv4/af_inet.c

However, I'd like to modify the module and post it for people with new kernels to also use without having to modify their ipv4 support in the kernel.  Has something else come along and deprecated tcp_protocol that I should use instead?

Thanks!
George

