Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWEKUGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWEKUGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 16:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWEKUGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 16:06:50 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:52425 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750758AbWEKUGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 16:06:50 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: SecurityFocus Article
Date: Thu, 11 May 2006 22:03:46 +0200
User-Agent: KMail/1.9.1
Cc: "Ed White" <ed.white@libero.it>, "ML" <linux-kernel@vger.kernel.org>
References: <20060511143440.23517.qmail@securityfocus.com> <Pine.LNX.4.61.0605111140030.3833@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0605111140030.3833@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605112203.46996.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 11. May 2006 17:47, linux-os (Dick Johnson) wrote:
> If the SMRAM control register exists, the D_LCK bit can be set
> in 16-bit mode during the boot sequence. This makes the SMRAM
> register read/only so the long potential compromise sequence
> that Mr. Duflot describes would not be possible. If the control
> register doesn't exist, then the vulnerably doesn't exist.
> 
> The writer doesn't like the fact that a root process can execute
> iopl(3) and then be able to read/write ports. He doesn't like
> the fact that the X-server can read/write ports from user-mode.
> 
> Sorry, the X-server is too large to go into the kernel. It's
> a lot easier to modify the boot-loader to set the D_LCK bit
> if the security compromise turns out to be real.

That sounds like a good move.

Any patches?

I would love to review them!


Regards

Ingo Oeser
