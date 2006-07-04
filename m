Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWGDHlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWGDHlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWGDHlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:41:21 -0400
Received: from mx02.qsc.de ([213.148.130.14]:42159 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S1751117AbWGDHlS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:41:18 -0400
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCODE
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Date: Tue, 4 Jul 2006 09:41:07 +0200
User-Agent: KMail/1.9.3
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
References: <200607031117.k63BHiDa007719@harpo.it.uu.se>
In-Reply-To: <200607031117.k63BHiDa007719@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607040941.07108.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Monday 03 July 2006 13:17, Mikael Pettersson
	wrote: > In 2.6.17 sparc64 kernels, X11 runs _extremely_ slowly with >
	frequent lock-up like behaviour on my Ultra5 (ATI Mach64). > I finally
	managed to trace the cause to this change in 2.6.16-git6: [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 03 July 2006 13:17, Mikael Pettersson wrote:
> In 2.6.17 sparc64 kernels, X11 runs _extremely_ slowly with
> frequent lock-up like behaviour on my Ultra5 (ATI Mach64).
> I finally managed to trace the cause to this change in 2.6.16-git6:

I can confirm this behaviour, on a U5 with ATi onboard, but for me it
happens also on the Creator 3D of a U30, likewise.

I'll try to test if this changeset makes a difference for me as well
as soon as possible.

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rebe.name
            +49 (0)30 / 255 897 45
