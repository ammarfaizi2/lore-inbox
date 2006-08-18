Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWHRNGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWHRNGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWHRNGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:06:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:18883 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932324AbWHRNGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:06:41 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 2/5] -fstack-protector feature: Add the Kconfig option
Date: Fri, 18 Aug 2006 16:05:19 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1155746902.3023.63.camel@laptopd505.fenrus.org> <200608181308.07752.ak@suse.de> <1155900206.4494.141.camel@laptopd505.fenrus.org>
In-Reply-To: <1155900206.4494.141.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608181605.19520.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> the binary search argument in this case is moot, just having a config
> option doesn't break anything compile wise and each later step is
> self-compiling..

Not true when the config used for the binary search has stack protector
enabled.

-Andi
