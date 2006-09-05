Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbWIER5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbWIER5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 13:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbWIER5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 13:57:19 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:16840 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965239AbWIER5T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:57:19 -0400
Subject: Re: [Feature] x86_64 page tracking for Stratus servers
From: Dave Hansen <haveblue@us.ibm.com>
To: Kimball Murray <kimball.murray@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, ak@suse.de
In-Reply-To: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com>
References: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 10:56:57 -0700
Message-Id: <1157479017.3186.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 13:34 -0400, Kimball Murray wrote:
> +static __inline__ void mm_track_pte(void * val)
> +{
> +       if (unlikely(mm_tracking_struct.active))
> +               do_mm_track_pte(val);
> +} 

This patch just appears to be a big collection of hooks.  Could you post
an example user of these hooks?  It is obviously GPL from all of the
EXPORT_SYMBOL_GPL()s anyway, right?

-- Dave

