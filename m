Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbVHTECs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbVHTECs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 00:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbVHTECs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 00:02:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63159 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1030207AbVHTECr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 00:02:47 -0400
Date: Sat, 20 Aug 2005 05:05:37 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Ameer Armaly <ameer@bellsouth.net>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, trivial@rustcorp.com.au
Subject: Re: [patch] remove call to check_region in drivers/pnp/resource.c
Message-ID: <20050820040537.GO29811@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.61.0508192336050.575@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508192336050.575@debian>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 11:46:59PM -0400, Ameer Armaly wrote:
> This patch removes a call to check_region in drivers/pnp/resource.c, and 
> replaces it with request_region.

... and that replacement is correct, because...?
