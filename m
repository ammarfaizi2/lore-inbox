Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVBHXoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVBHXoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVBHXoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:44:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:37303 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261702AbVBHXn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:43:27 -0500
Date: Tue, 8 Feb 2005 15:43:26 -0800
From: Chris Wright <chrisw@osdl.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] BSD Secure Levels: nits, 2.6.11-rc2-mm1 (6/8)
Message-ID: <20050208154326.E469@build.pdx.osdl.net>
References: <20050207192108.GA776@halcrow.us> <20050207193518.GE834@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050207193518.GE834@halcrow.us>; from mhalcrow@us.ibm.com on Mon, Feb 07, 2005 at 01:35:19PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Halcrow (mhalcrow@us.ibm.com) wrote:
> This is the sixth in a series of eight patches to the BSD Secure
> Levels LSM.  It makes several trivial changes to make the code
> consistent.

These are inconsistent with CodingStyle.  I'd drop this, and go the
other way (patch is smaller) ala Lindent.

>  struct seclvl_obj {
> -	char *name;
> +	char * name;

This is opposite of typical style.

> -seclvl_attr_store(struct kobject *kobj,
> -		  struct attribute *attr, const char *buf, size_t len)
> +seclvl_attr_store(struct kobject * kobj,
> +		  struct attribute * attr, const char * buf, size_t len)

same here...etc.

Lindent nearly undoes all these changes.  If we're going to reformat
code, I'd prefer to see it done via Lindent.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
