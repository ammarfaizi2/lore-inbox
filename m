Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965237AbWFAFcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbWFAFcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbWFAFcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:32:11 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:29825 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S965098AbWFAFcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:32:10 -0400
Date: Wed, 31 May 2006 22:34:59 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 008 of 10] md: Allow raid 'layout' to be read and set via sysfs.
Message-ID: <20060601053459.GL2697@moss.sous-sol.org>
References: <20060601150955.27444.patches@notabene> <1060601051408.27637@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060601051408.27637@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* NeilBrown (neilb@suse.de) wrote:
> +static struct md_sysfs_entry md_layout =
> +__ATTR(layout, 0655, layout_show, layout_store);

0644?
