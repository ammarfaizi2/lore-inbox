Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbUKUXm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbUKUXm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUKUXm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:42:29 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:17150 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261852AbUKUXlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:41:24 -0500
Date: Sun, 21 Nov 2004 15:43:30 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sparse segfaults
Message-ID: <20041121234330.GA28381@gaz.sfgoth.com>
References: <20041120143755.E13550@flint.arm.linux.org.uk> <Pine.LNX.4.61.0411211705480.16359@chaos.analogic.com> <Pine.LNX.4.58.0411211433540.20993@ppc970.osdl.org> <Pine.LNX.4.53.0411212343340.17752@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411212343340.17752@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Sun, 21 Nov 2004 15:43:30 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> >Actually, this is documented gcc behaviour,[...]
> >you can do
> >	int tickadj = *ptr++ ? : 1;
> >and it's well-behaved in that it increments the pointer only once.
> 
> And it's specific to GCC. This kinda ruins some tries to get ICC working on the
> kernel tree :)

By ICC do you mean the Intel compiler?  It's supported the GCC Extension
"Conditionals with Omitted Operands" since at least version 5.0.1.  See:
  http://www.intel.com/software/products/compilers/c50/linux/comp501.pdf

-Mitch
