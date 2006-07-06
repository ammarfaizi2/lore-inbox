Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWGFNLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWGFNLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 09:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWGFNLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 09:11:30 -0400
Received: from canuck.infradead.org ([205.233.218.70]:27596 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1030258AbWGFNLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 09:11:30 -0400
Subject: Re: [GIT *] Remove inclusion of obsolete <linux/config.h>
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, sam@ravnborg.org, linux-kernel@vger.kernel.org
In-Reply-To: <1152191265.2987.154.camel@pmac.infradead.org>
References: <1152191265.2987.154.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 14:11:22 +0100
Message-Id: <1152191482.2987.157.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 14:07 +0100, David Woodhouse wrote:
> Linus, please pull from git://git.infradead.org/~dwmw2/killconfig.h.git
> 
> This contains two commits. The first removes all inclusions of
> <linux/config.h> from the kernel sources, and the second turns
> include/linux/config.h into a one-line #error.

Btw, Andrew...

hera /pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/broken-out $ grep "+#include <linux/config.h>" * -l
acx1xx-wireless-driver.patch
apple-motion-sensor-driver.patch
edac-new-opteron-athlon64-memory-controller-driver.patch
git-ia64.patch
git-klibc.patch
git-sas.patch
git-watchdog.patch
gregkh-usb-usb-gotemp.patch
gregkh-usb-usb-serial-mos7720.patch
mutex-subsystem-synchro-test-module.patch
origin.patch
reiser4.patch
touchkit-ps-2-touchscreen-driver.patch


-- 
dwmw2

