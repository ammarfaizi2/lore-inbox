Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265893AbRF3L7W>; Sat, 30 Jun 2001 07:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbRF3L7C>; Sat, 30 Jun 2001 07:59:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7177 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265893AbRF3L67>;
	Sat, 30 Jun 2001 07:58:59 -0400
Date: Sat, 30 Jun 2001 12:58:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, kaos@ocs.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Message-ID: <20010630125855.B12788@flint.arm.linux.org.uk>
In-Reply-To: <20010630102024.A12009@flint.arm.linux.org.uk> <E15GJAI-0001w1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15GJAI-0001w1-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Jun 30, 2001 at 12:43:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2001 at 12:43:54PM +0100, Alan Cox wrote:
> > Err, how can $BAR be undefined?  Configure sets all config variables which
> > are answered with 'n' to 'n'.
> 
> Welcome to the 'if' statement....

Thank you, yes, but I believe we were talking about dep_* and not if
statements?

> From a first review I can't - but we need to verify that is the case
> completely before we make the change.

Indeed.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

