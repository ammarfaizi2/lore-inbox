Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTDYU6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 16:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263989AbTDYU6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 16:58:24 -0400
Received: from franka.aracnet.com ([216.99.193.44]:53460 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263985AbTDYU6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 16:58:23 -0400
Date: Fri, 25 Apr 2003 14:10:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
Message-ID: <1750000.1051305030@[10.10.2.4]>
In-Reply-To: <b8c7no$u59$1@cesium.transmeta.com>
References: <459930000.1051302738@[10.10.2.4]>
 <b8c7no$u59$1@cesium.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is there any good reason we can't remove TASK_UNMAPPED_BASE, and just
>> shove libraries directly above the program text? Red Hat seems to have
>> patches to dynamically tune it on a per-processes basis anyway ...
>> 
>> Moreover, can we put the stack back where it's meant to be, below the
>> program text, in that wasted 128MB of virtual space? Who really wants 
>> > 128MB of stack anyway (and can't fix their app)?
> 
> That space is NULL pointer trap zone.  NULL pointer trapping -> good.

128Mb of it? The bottom page, or even a few Mb, sure ... 
but 128Mb seems somewhat excessive ...

M.

