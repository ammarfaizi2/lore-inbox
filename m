Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbVCPV1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVCPV1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVCPV1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:27:01 -0500
Received: from fire.osdl.org ([65.172.181.4]:54711 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262812AbVCPV0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:26:21 -0500
Date: Wed, 16 Mar 2005 13:26:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
Message-Id: <20050316132600.3f6e4df2.akpm@osdl.org>
In-Reply-To: <1110985632l.8879l.0l@werewolf.able.es>
References: <20050316040654.62881834.akpm@osdl.org>
	<1110985632l.8879l.0l@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> On 03.16, Andrew Morton wrote:
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/
>  > 
>  ...
>  >
>  > +revert-gconfig-changes.patch
>  > 
>  >  Back out a recent change which broke gconfig.
>  > 
> 
>  What was broken ?

hm.  I emailed you twice, and had a feeling that things weren't getting
through.

The patch caused those little pixmap buttons across the top of the main
window to vanish when using gtk+-1.2.10-28.1.  See
http://www.zip.com.au/~akpm/linux/patches/stuff/x.jpg.

I now note that scripts/kconfig/gconf.c doesn't compile at all with the
above backout patch.  Drat.

