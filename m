Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWCVPDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWCVPDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWCVPDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:03:38 -0500
Received: from cantor2.suse.de ([195.135.220.15]:14977 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751277AbWCVPDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:03:31 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 17/35] Segment register changes for Xen
Date: Wed, 22 Mar 2006 15:24:17 +0100
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063752.889921000@sorel.sous-sol.org>
In-Reply-To: <20060322063752.889921000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221524.17388.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 07:30, Chris Wright wrote:

> +#define get_kernel_cs() \
> +	(__KERNEL_CS + (xen_feature(XENFEAT_supervisor_mode_kernel) ? 0 : 1))

Under what circumstances is that feature set?

-Andi

