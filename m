Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWGMHqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWGMHqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWGMHqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:46:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8163 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751334AbWGMHqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:46:22 -0400
Subject: Re: Expertise required on building code for SMP
From: Arjan van de Ven <arjan@infradead.org>
To: bhuvan.kumarmital@wipro.com
Cc: linux-usb-devel@lists.sourceforge.net, kernelnewbies-request@nl.linux.org,
       kernel-mentors@selenic.com, os_drivers@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <24ED22E506B5A042BF5B05B6B017D86C0A9046@PNE-HJN-MBX01.wipro.com>
References: <24ED22E506B5A042BF5B05B6B017D86C0A9046@PNE-HJN-MBX01.wipro.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 09:45:37 +0200
Message-Id: <1152776737.3024.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 13:12 +0530, bhuvan.kumarmital@wipro.com wrote:
> We've written a device driver in linux for a pcmcia card with usb and
> serial functionality. I need to test this driver on a dual core/SMP
> machine. We work on kernel 2.6.15.4. I have recompiled this kernel
> version on my dual core machine with the CONFIG_SMP flag set during
> menuconfig.
> 
> How do i ensure that my driver is making use of the SMP feature? Do
> build my driver code i have a makefile in which i use the EXTRA_CFLAGS=
> -D__SMP__ -DCONFIG_SMP -DLINUX.

NO!

You should just use a normal KBuild makefile, and not ever add any extra
cflags....

(but you failed to provide a URL to even your Makefile but also to your
code so it's hard to give you a detailed recommendation)

