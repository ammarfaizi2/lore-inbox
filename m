Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVA0AQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVA0AQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVA0AQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:16:17 -0500
Received: from gate.crashing.org ([63.228.1.57]:48086 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262477AbVAZWPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 17:15:17 -0500
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <41F80CA2.2080603@246tNt.com>
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>
	 <1106441036.5387.41.camel@gaston> <1106529935.5587.9.camel@gaston>
	 <41F80CA2.2080603@246tNt.com>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 09:11:54 +1100
Message-Id: <1106777515.6249.79.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 22:33 +0100, Sylvain Munaut wrote:

> >Finally, try that patch and tell me if it makes a difference. 
> >
> Yup
>  - Without it hangs (not really, it's still half running but serial 
> output is stuck
> due to no interrupts)
>  - With it it works

Well, in the meantime, Ingo made a proper fix to rest_init()

Ben.


