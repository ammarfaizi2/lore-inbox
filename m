Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264214AbUDHIzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 04:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbUDHIzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 04:55:21 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:29320 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S264214AbUDHIzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 04:55:19 -0400
Date: Thu, 8 Apr 2004 08:55:18 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: cat /dev/hdb > /dev/null DoS
Message-ID: <20040408085518.B4607@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have 2.8 GHz Pentium IV with 1GB RAM and 250GB ATA-133 IDE disk
on /dev/hdb.

I did cat /dev/hdb > /dev/null and after a while (5 minutes),
the system went totally unresponsive:

1) man top takes 3 minutes to display man page
2) Switching between console and X takes also a couple of minutes
3) top shows this:

Cpu(s):  1.4% us,  1.4% sy,  0.0% ni,  0.0% id,  0.0% wa, 97.3% hi,  0.0% si

/dev/hdb is auxilliary disk that is not used, is not mounted and the
root filesystem doesn't reside on it (of course). Kernel version is 2.6.3.

Is this behaviour normal?

Cl<
