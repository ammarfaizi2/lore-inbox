Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWCVTSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWCVTSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWCVTSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:18:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:22435 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932374AbWCVTSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:18:24 -0500
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [RFC PATCH 10/35] Add a new head.S start-of-day file for booting on Xen.
Date: Wed, 22 Mar 2006 19:45:34 +0100
User-Agent: KMail/1.9.1
Cc: virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <200603221443.54119.ak@suse.de> <20060322185836.GZ15997@sorel.sous-sol.org>
In-Reply-To: <20060322185836.GZ15997@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221945.35113.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 19:58, Chris Wright wrote:

> 
> There's still kernel/user cs/ds in gdt, so it's not all zero.

Make them symbol with a common macro then.

-Andi
