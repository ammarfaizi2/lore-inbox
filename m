Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278414AbRJSNvo>; Fri, 19 Oct 2001 09:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278422AbRJSNve>; Fri, 19 Oct 2001 09:51:34 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:56272 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S278414AbRJSNv1>; Fri, 19 Oct 2001 09:51:27 -0400
Date: Fri, 19 Oct 2001 14:50:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: linux-2.4.13-pre5/drivers/message/i2o directory adjustments
Message-ID: <20011019145043.A990@flint.arm.linux.org.uk>
In-Reply-To: <20011019055944.A9176@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011019055944.A9176@baldur.yggdrasil.com>; from adam@yggdrasil.com on Fri, Oct 19, 2001 at 05:59:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 05:59:44AM -0700, Adam J. Richter wrote:
> 	Some files in linux-2.4.13-pre5 were not updated to reflect
> the fact that drivers/i2o was moved to drivers/message/i2o, so the
> kernel will not compile.  Also, it looks like the code expects
> the "pdev" field to be part of struct i2o_pci, but the .h file
> was not updated.  I have included a possible patch to fix that
> problem too, although perhaps the i2o maintainers may wish to
> propose a different patch.

Please look at the 12-ac3 patch - Alan didn't finish merging the i2o
changes, and you should take the fix for this from the -ac tree.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

