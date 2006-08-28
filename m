Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWH1IFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWH1IFF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWH1IFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:05:05 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:5472 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751405AbWH1IFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:05:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OFjm6IiAzI//LRibvI0+fYhMu1p54I5yfMJs34X4eEKDVaQCsByci2Xr6QRNmI1viYbthQxIg5YV+3y7sclro9NlzwI8xy64RlYyx8yGJAx+w4wlOaq1pCxEMQ6zFbZY/cwjbDQBbtP+VUuXmtC6ngKiuBW67uUl+rCQ2kYGRpE=
Message-ID: <b0943d9e0608280105s2fb1d155nf1a7a10661b8f98d@mail.gmail.com>
Date: Mon, 28 Aug 2006 09:05:01 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Linux v2.6.18-rc5
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       "Shailabh Nagar" <nagar@watson.ibm.com>
In-Reply-To: <20060827231421.f0fc9db1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	 <20060827231421.f0fc9db1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sun, 27 Aug 2006 21:30:50 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
>
> > Linux 2.6.18-rc5 is out there now
[...]
> From: "Catalin Marinas" <catalin.marinas@gmail.com>
> Subject: Possible memory leak in kernel/delayacct.c

Michal (cc'ed) reported that the leak no longer shows with a patch
from Shailabh - http://lkml.org/lkml/2006/8/22/246. It doesn't seem
that the patch was merged yet so I suspect the problem is still there.

-- 
Catalin
