Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTI2RVI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbTI2RU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:20:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54535 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263861AbTI2RTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:19:05 -0400
Date: Mon, 29 Sep 2003 18:19:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: davej@redhat.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unnecessary checks in pcmcia
Message-ID: <20030929181901.A7593@flint.arm.linux.org.uk>
Mail-Followup-To: davej@redhat.com, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1A41Rq-0000NP-00@hardwired>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1A41Rq-0000NP-00@hardwired>; from davej@redhat.com on Mon, Sep 29, 2003 at 06:04:34PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 06:04:34PM +0100, davej@redhat.com wrote:
> io->stop/start are 16 bits, so will never be >0xffff

Not necessarily.  On x86 yes.  On ARM, no.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
