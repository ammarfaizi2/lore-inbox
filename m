Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965234AbWFAFbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbWFAFbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbWFAFbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:31:09 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:38273 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S965085AbWFAFbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:31:08 -0400
Date: Wed, 31 May 2006 22:33:56 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 006 of 10] md: Set/get state of array via sysfs
Message-ID: <20060601053356.GK2697@moss.sous-sol.org>
References: <20060601150955.27444.patches@notabene> <1060601051358.27613@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060601051358.27613@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* NeilBrown (neilb@suse.de) wrote:
> 
> This allows the state of an md/array to be directly controlled
> via sysfs and adds the ability to stop and array without
> tearing it down.
> 
> Array states/settings:
> 
>  clear
>      No devices, no size, no level
>      Equivalent to STOP_ARRAY ioctl

It looks like this demoted CAP_SYS_ADMIN to CAP_DAC_OVERRIDE for the
equiv ioctl.  Intentional?
