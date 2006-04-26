Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWDZO1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWDZO1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWDZO1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:27:43 -0400
Received: from isilmar.linta.de ([213.239.214.66]:53972 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932336AbWDZO1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:27:43 -0400
Date: Wed, 26 Apr 2006 16:27:41 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Jan Beulich <jbeulich@novell.com>
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq {d,}printk adjustments
Message-ID: <20060426142741.GA30902@isilmar.linta.de>
Mail-Followup-To: Jan Beulich <jbeulich@novell.com>,
	cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
References: <444F93E5.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444F93E5.76E4.0078.0@novell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 26, 2006 at 03:38:13PM +0200, Jan Beulich wrote:
> Convert some dprintk-s to printk-s as their use of KERN_* indicates they
> were meant to be used that way. Alternatively, the KERN_* prefixes could
> be removed and the dprintk-s then retained.

For these ones, removing KERN_* and leaving them as dprintk() seems to be
the better choice. The other two patches look fine to me.

Thanks!

	Dominik
