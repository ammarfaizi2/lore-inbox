Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVACUom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVACUom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 15:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVACUom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 15:44:42 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:40849 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261762AbVACUoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 15:44:32 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [bootfix] pass used_node_mask by reference in 2.6.10-mm1
Date: Mon, 3 Jan 2005 12:44:06 -0800
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050103191319.GO29332@holomorphy.com> <20050103195016.GP29332@holomorphy.com>
In-Reply-To: <20050103195016.GP29332@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501031244.06651.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 3, 2005 11:50 am, William Lee Irwin III wrote:
> On Mon, Jan 03, 2005 at 11:13:19AM -0800, William Lee Irwin III wrote:
> > Without passing this parameter by reference, the changes to
> > used_node_mask are meaningless and do not affect the caller's copy.
> > This leads to boot-time failure. This proposed fix passes it by
> > reference.
>
> This proposed fix is an actual fix according to my own testing.
>
> Without the patch applied, my quad em64t does not boot, and livelocks
> prior to console_init().
>
> With the patch applied, my quad em64 boots and runs normally.

Makes my Altix boot as well.  Thanks for the fix.

Jesse
