Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbTIJRG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbTIJRG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:06:27 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:44499 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP id S265298AbTIJRG0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:06:26 -0400
Message-ID: <3F5F5A22.956A72A6@pp.inet.fi>
Date: Wed, 10 Sep 2003 20:06:42 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org, cryptoapi-devel@kerneli.org
Subject: Re: [PATCH] AES i586-asm optimized
References: <20030910153859.GA17919@leto2.endorphin.org> <20030910161738.GA29990@gtf.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Wed, Sep 10, 2003 at 05:38:59PM +0200, Fruhwirth Clemens wrote:
> > As tested by hvr[2] this implemention is significantly faster than the C
> > version.
> 
> Tested on what processors?  With what kernel config?
> 
> I would be surprised if a 586-optimized asm was useful on P4.

It uses classic Pentium instruction set. Speed optimized for my 300 MHz
Pentium-2 test box. Original Gladman version that I started with was pretty
fast but I was able to improve performance about 7% over original version.

On my same 300 MHz P2 test box, assembler implementation is about twice as
fast as the mainline kernel C implementation.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

