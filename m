Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbUKCVYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUKCVYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbUKCVX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:23:59 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:31416 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261891AbUKCVU2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:20:28 -0500
Date: Wed, 3 Nov 2004 22:17:38 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: David Gibson <hermes@gibson.dropbear.id.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Roskin <proski@gnu.org>, orinoco-deve@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Another trivial orinoco update
Message-ID: <20041103211738.GA14377@electric-eye.fr.zoreil.com>
References: <20041103034433.GB5441@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103034433.GB5441@zax>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <hermes@gibson.dropbear.id.au> :
[...]
> This patch alters the convention with which orinoco_lock() is invoked
> in the orinoco driver.  This should cause no behavioural change, but
> reduces meaningless diffs between the mainline and CVS version of the
> driver.  Another small step towards a merge.

Afaics orinico_lock returns a nice status code. Let alone the merge
argument (which could be solved in the CVS tree as well), is there a
technical reason for this patch ?

--
Ueimor
