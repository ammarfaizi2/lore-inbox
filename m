Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUH0M4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUH0M4p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 08:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUH0M4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 08:56:45 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:57285 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S264668AbUH0M4l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 08:56:41 -0400
X-Qmail-Scanner-Mail-From: solt@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.23 (Clear:RC:0(150.254.37.14):. Processed in 0.031201 secs)
Date: Fri, 27 Aug 2004 14:56:40 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: SecureBat! Lite (v2.10.02) Personal
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <581631760.20040827145640@dns.toxicfilms.tv>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] README - Explain new 2.6.xx.x bug-fix release numbering scheme
In-Reply-To: <412F2B79.40609@linux-user.net>
References: <412F2B79.40609@linux-user.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

DA> +   As of kernel 2.6.8 there was a bug-fix release numbering scheme
DA> +   introduced. In such cases a fourth number is added to the release
DA> +   version, eg. 2.6.8.1. When patching from a 2.6.xx(.x) release to a
DA> +   newer version, patches are to be applied against the original
DA> +   release, eg. 2.6.8 and not the bug-fix release 2.6.8.1. Old patches
DA> +   can be reversed by adding the "-R" option to patch.
DA> +
How about giving an example like:

    To apply a bugfix release patch:
    # cd /usr/src/linux-2.6.8
    # patch -p1 <../patch-2.6.8.1

    To apply a new release on a bugfix tree:
    # cd /usr/src/linux-2.6.8.1
    # patch -p1 -R <../patch-2.6.8.1
    # patch -p1 <../patch-2.6.9

Examples are always good.
    
Regards,
Maciej


