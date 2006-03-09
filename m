Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751906AbWCIMD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbWCIMD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbWCIMD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:03:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751939AbWCIMDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:03:34 -0500
Date: Thu, 9 Mar 2006 04:01:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: tony.luck@intel.com, ak@suse.de, jschopp@austin.ibm.com,
       haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH: 011/017](RFC) Memory hotplug for new nodes v.3. (start
 kswapd)
Message-Id: <20060309040100.0d258a25.akpm@osdl.org>
In-Reply-To: <20060308213333.0038.Y-GOTO@jp.fujitsu.com>
References: <20060308213333.0038.Y-GOTO@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
>
>  +EXPORT_SYMBOL(kswapd_run);

Does this need to be exported to modules?

If so, EXPORT_SYMBOL_GPL would be preferred, please.
