Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbTK0MN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 07:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTK0MN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 07:13:58 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:59859 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264501AbTK0MN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 07:13:56 -0500
Date: Thu, 27 Nov 2003 13:13:53 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test11 compiler warnings
Message-ID: <20031127121353.GA13984@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/ipv4/ipcomp.c: In function `ipcomp_input':
net/ipv4/ipcomp.c:72: Warnung: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1136)
net/ipv4/ipcomp.c: In function `ipcomp_output':
net/ipv4/ipcomp.c:189: Warnung: `skb_linearize' is deprecated (declared at include/linux/skbuff.h:1136)

This is only visible with CONFIG_INET_IPCOMP (which is recommended in
the Kconfig --help-- section, but disabled by default on i386).

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
