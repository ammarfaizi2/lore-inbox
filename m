Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbSKNWIL>; Thu, 14 Nov 2002 17:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSKNWIE>; Thu, 14 Nov 2002 17:08:04 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:28056 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S261627AbSKNWHz>;
	Thu, 14 Nov 2002 17:07:55 -0500
Date: Thu, 14 Nov 2002 21:05:54 +0000
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] early printk for x86
Message-ID: <20021114210554.GM28216@skynet.ie>
References: <3DD3FCB3.40506@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3DD3FCB3.40506@us.ibm.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VGA and serial are certainly not hammer+ia32-specific.  Make the generic 
parts generic...   the arch-specific components would need to change 
early-foo base addresses perhaps, but otherwise, it's pretty generic.

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
