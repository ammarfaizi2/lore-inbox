Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbUJ2HBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUJ2HBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 03:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUJ2HBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 03:01:39 -0400
Received: from fmr02.intel.com ([192.55.52.25]:29650 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263126AbUJ2HA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 03:00:57 -0400
Subject: Re: ERROR: Disabling IRQ #11
From: Len Brown <len.brown@intel.com>
To: Kahro Raie <kahroo@hot.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041029062746.B69E312CE@portal.hot.ee>
References: <20041029062746.B69E312CE@portal.hot.ee>
Content-Type: text/plain
Organization: 
Message-Id: <1099033246.5403.246.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 29 Oct 2004 03:00:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 02:27, Kahro Raie wrote:
> Description:
> After my system has been up for about 10 minutes I allways get the
> following 2 line error message on every console:

> irq 11: nobody cared!
...
> Disabling IRQ #11

APIC error on CPU0: 00(01)

Hmmm, how did we take this interrupt with no bits set?
why do we have bit 0 (send checksum error) set after
we try to clear "errors"?

Did you not see this issue when running a different kernel, or do you
always see this issue?

Is the board over-clocked?

-Len


