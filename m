Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751879AbWCNGwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbWCNGwn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 01:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWCNGwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 01:52:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751879AbWCNGwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 01:52:42 -0500
Date: Mon, 13 Mar 2006 22:50:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Stone, Joshua I" <joshua.i.stone@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exports for hrtimer APIs
Message-Id: <20060313225015.7f5fb955.akpm@osdl.org>
In-Reply-To: <CBDB88BFD06F7F408399DBCF8776B3DC06A48C31@scsmsx403.amr.corp.intel.com>
References: <CBDB88BFD06F7F408399DBCF8776B3DC06A48C31@scsmsx403.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stone, Joshua I" <joshua.i.stone@intel.com> wrote:
>
> Hi,
> 
> I have noticed that the hrtimer APIs in 2.6.16 RCs are not exported, and
> therefore modules are unable to use hrtimers.  I have not seen any
> discussion on this point, so I presume that this is either an oversight,
> or there has not been any case presented for exporting hrtimers.
> 
> I would like to add hrtimer support to SystemTap, which by design
> requires the use of dynamically loaded kernel modules.  Can the
> appropriate exports for hrtimers please be added?
> 

Please send a patch, so we can see what's needed.

EXPORT_SYMBOL_GPL would be preferred.
