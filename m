Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVCJEMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVCJEMU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVCJEMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:12:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:43400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261193AbVCJEKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 23:10:54 -0500
Date: Wed, 9 Mar 2005 20:10:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Lang <dlang@digitalinsight.com>
Cc: kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Direct io on block device has performance regression on 2.6.x
 kernel
Message-Id: <20050309201022.7302d2ac.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0503092000210.4446@qynat.qvtvafvgr.pbz>
References: <200503100347.j2A3lRg28975@unix-os.sc.intel.com>
	<Pine.LNX.4.62.0503092000210.4446@qynat.qvtvafvgr.pbz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <dlang@digitalinsight.com> wrote:
>
> (I've seen a 50% 
>  performance hit on 2.4 with just a thousand or two threads compared to 
>  2.6)

Was that 2.4 kernel a vendor kernel with the O(1) scheduler?
