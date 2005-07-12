Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVGLAFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVGLAFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 20:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVGLAFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 20:05:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262277AbVGLAEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 20:04:50 -0400
Date: Mon, 11 Jul 2005 17:05:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hal Rosenstock <halr@voltaire.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>
Subject: Re: [PATCH 0/29v2] InfiniBand core update
Message-Id: <20050711170548.31605e23.akpm@osdl.org>
In-Reply-To: <1121110249.4389.4984.camel@hal.voltaire.com>
References: <1121110249.4389.4984.camel@hal.voltaire.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hal Rosenstock <halr@voltaire.com> wrote:
>
> This is version 2 of a patch series to get the Infiniband core up to
> date.

Well that was interesting.

- All the patches had mangled headers:

-- linux-2.6.13-rc2-mm1-16/...
+++ linux-2.6.13-rc2-mm1-17/...

  instead of

--- linux-2.6.13-rc2-mm1-16/...
+++ linux-2.6.13-rc2-mm1-17/...

  Which I fixed up.

- The second patch didn't apply.  I fixed that too.

- The patches add lots of trailing whitespace.  I habitually trim that
  off, figuring that any downstream merging hassle which that causes is
  just punishment ;)


Please check that it all landed OK in the next -mm.

I've hung on to Tom Duffy's patch pending a test compilation.

I'll tentatively consider this material to be not-for-2.6.13?

