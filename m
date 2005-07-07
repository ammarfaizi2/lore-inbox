Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVGGKcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVGGKcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 06:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVGGKcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 06:32:07 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:38072 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261171AbVGGKcA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 06:32:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gTJWK/fZGDbvnFVM+9KFdU5SpMO5PoUXvCMy3hA9M+ugrqjP3T1hfCDybZy5gCdazjJwqleocFs3jpLFkIUr5TK8EWRpTnNEk9JPs/JH7plT4anfU4R6I/XmTEH2mjXy9uh39U6b82bOpNCEgfrbZaCQJSOOyIHEVUR0AZWnF4k=
Message-ID: <21d7e9970507070331107831c6@mail.gmail.com>
Date: Thu, 7 Jul 2005 20:31:59 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Miles Lane <miles.lane@gmail.com>
Subject: Re: OOPS in 2.6.13-rc1-mm1 -- EIP is at sysfs_release+0x49/0xb0
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd05070301417531fac2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a44ae5cd05070301417531fac2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/05, Miles Lane <miles.lane@gmail.com> wrote:
> mtrr: base(0xe8020000) is not aligned on a size(0x3c0000) boundary
> [drm:drm_unlock] *ERROR* Process 4470 using kernel context 0
> mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x1000000
> Unable to handle kernel paging request at virtual address 5f78735f

That is a bit suspicious.. what distro/X are you using? if you are
running a newer X (I think anything after XFree86 4.3) you should be
using the i915 DRM not the i830..

Dave.
