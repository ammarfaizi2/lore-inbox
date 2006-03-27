Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWC0EAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWC0EAZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 23:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWC0EAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 23:00:25 -0500
Received: from ozlabs.org ([203.10.76.45]:62189 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751598AbWC0EAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 23:00:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17447.25413.486950.115568@cargo.ozlabs.ibm.com>
Date: Mon, 27 Mar 2006 15:00:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <abergman@de.ibm.com>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, "Ryan S. Arnold" <rsa@us.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [patch 01/13] powerpc: hvc_console updates
In-Reply-To: <20060323203520.909999000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060323203520.909999000@dyn-9-152-242-103.boeblingen.de.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> Also shuffle around some data-type declarations and moves some
> functions out of include/asm-ppc64/hvconsole.h and into a new
> drivers/char/hvc_console.h file.

Unfortunately this causes compile failures because the declarations of
hvc_instantiate and hvc_alloc in include/asm-powerpc/hvconsole.h now
don't have the definition of struct hv_ops available to them.  I'll
ignore your 1/13 and 2/13 patches for now - please send fixed
versions.

Paul.
