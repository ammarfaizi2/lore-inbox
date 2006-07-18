Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWGRQZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWGRQZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 12:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWGRQZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 12:25:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:9118 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751361AbWGRQZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 12:25:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=hok+EmR2Kqt87R6YnKJ9XleEbq9rQgw9iMTYgA/rPRklyUPX5u9sByCmrk8dtN9sthcH2JPBnIrlbvzL/LGpwOn023QP2amNa81SLs0xJwcbDyE0q4SbldeL7HHUDSXxgmBM5ROPYiVc0TaXQ3wpK+MjVctrcwkEjMHST0Q1/mw=
Message-ID: <84144f020607180925s62e6a7abvbaf66c672849170b@mail.gmail.com>
Date: Tue, 18 Jul 2006 19:25:50 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "yunfeng zhang" <zyf.zeroos@gmail.com>
Subject: Re: Improvement on memory subsystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
X-Google-Sender-Auth: 969317e0f8c3fab2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/06, yunfeng zhang <zyf.zeroos@gmail.com> wrote:
> 3. All slabs are all off-slab type. Store slab instance in page structure.

Not sure what you mean. We need much more than sizeof(struct page) for
slab management. Hmm?
