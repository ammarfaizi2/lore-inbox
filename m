Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVCUWbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVCUWbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVCUW15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:27:57 -0500
Received: from ozlabs.org ([203.10.76.45]:62896 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262074AbVCUW1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:27:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16959.17091.901784.666693@cargo.ozlabs.ibm.com>
Date: Tue, 22 Mar 2005 08:55:15 +1100
From: Paul Mackerras <paulus@samba.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH][2.6.12-rc1-mm1] fix compile error in ppc64 prom.c
In-Reply-To: <200503211519.j2LFJ1os021884@harpo.it.uu.se>
References: <200503211519.j2LFJ1os021884@harpo.it.uu.se>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson writes:

> Compiling 2.6.12-rc1-mm1 for ppc64 fails with:
> 
> arch/ppc64/kernel/prom.c:1691: error: syntax error before 'prom_reconfig_notifier'

Currently prom.c is in a mess because Linus applied the last 2 of 8
patches from Nathan Lynch but not the first 6.  :-P

Paul.
