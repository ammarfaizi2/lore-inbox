Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWDIUbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWDIUbf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 16:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWDIUbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 16:31:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16906 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750710AbWDIUbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 16:31:35 -0400
Date: Sun, 9 Apr 2006 21:30:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-arm-toolchain@lists.arm.linux.org.uk
Subject: Re: add new code section for kernel code
Message-ID: <20060409203046.GA24461@flint.arm.linux.org.uk>
Mail-Followup-To: saeed bishara <saeed.bishara@gmail.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Linux-arm-toolchain@lists.arm.linux.org.uk
References: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com> <20060406151003.0ef4e637@localhost> <c70ff3ad0604060947t728fbad9g2e3b35198f9b0f66@mail.gmail.com> <c70ff3ad0604070402p355a5695y28b5806cbf7bed0a@mail.gmail.com> <1144422864.3117.0.camel@laptopd505.fenrus.org> <20060407154349.GB31458@flint.arm.linux.org.uk> <c70ff3ad0604090253n7fe4de4che67f18380ffa2efd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c70ff3ad0604090253n7fe4de4che67f18380ffa2efd@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 12:53:56PM +0300, saeed bishara wrote:
> > I'd prefer not to paper over such bugs.  Maybe the following patch will
> > fix the decompressor for saeed?
> 
> yes, this patch fixed the problem.

Thanks for testing; I've applied this patch so 2.6.17-rc2 onwards will
have this fixed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
