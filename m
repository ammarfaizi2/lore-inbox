Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932771AbWAFR0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbWAFR0X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWAFR0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:26:21 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:56792 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932758AbWAFR0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:26:16 -0500
Date: Fri, 6 Jan 2006 10:26:15 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, hawkes@sgi.com,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       John Hesterberg <jh@sgi.com>, Greg Edwards <edwardsg@sgi.com>
Subject: Re: [PATCH] ia64: change defconfig to NR_CPUS==1024
Message-ID: <20060106172615.GE19769@parisc-linux.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F055A7AFB@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F055A7AFB@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 09:19:28AM -0800, Luck, Tony wrote:
> Would it be impossibly hard to make the >64 cpus case (when the code
> switches from a single word to an array) be dependent on a boot-time
> variable?  If we could, then the defconfig could just say 128, and
> users of monster machines would just boot with "maxcpus=4096" to increase
> the size of the bitmask arrays.

Why can't we keep the default below 64?  Surely the 0.1% of the market
which needs more than 64 cpus can recompile their kernel ...
