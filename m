Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbTHYGRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 02:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTHYGRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 02:17:05 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:38641 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S261533AbTHYGRD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 02:17:03 -0400
Date: Sun, 24 Aug 2003 23:16:54 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, domen@coderock.org
Subject: pcnet32 oops patches (was Re: 2.6.0-test4-mm1)
Message-ID: <20030825061654.GB3562@ip68-4-255-84.oc.oc.cox.net>
References: <20030824171318.4acf1182.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030824171318.4acf1182.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 05:13:18PM -0700, Andrew Morton wrote:
> +pcnet32-unregister_pci-fix.patch
> 
>  rmmod crash fix

Here's another (conflicting) patch by the same author:
http://bugme.osdl.org/attachment.cgi?id=684&action=view

There's an oops I'm having (bugzilla bug 976 -- basically, after
modprobing pcnet32 on a box without pcnet32 hardware, the next ethernet
driver to be modprobed blows up) which is not fixed by the patch in
test4-mm1, but which is fixed by attachment 684...

-Barry K. Nathan <barryn@pobox.com>
