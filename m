Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVC2VOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVC2VOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVC2VNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:13:30 -0500
Received: from mx03.cybersurf.com ([209.197.145.106]:51617 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S261448AbVC2VMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:12:05 -0500
Subject: Re: [Patch] net: fix build break when CONFIG_NET_CLS_ACT is not set
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Neil Horman <nhorman@redhat.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       netdev <netdev@oss.sgi.com>
In-Reply-To: <20050329202506.GI22447@hmsendeavour.rdu.redhat.com>
References: <20050329202506.GI22447@hmsendeavour.rdu.redhat.com>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1112130720.1076.112.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 29 Mar 2005 16:12:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is being discussed on netdev at the moment. Thomas Graf is working
on a patch.
Thanks for the effort though.

cheers,
jamal

On Tue, 2005-03-29 at 15:25, Neil Horman wrote:
> Patch to fix build break that occurs when CONFIG_NET_CLS_ACT is not set.
> 
> Signed-off-by: Neil Horman <nhorman@redhat.com>
> 
>  cls_fw.c      |    3 ++-
>  cls_route.c   |    3 ++-
>  cls_tcindex.c |    3 ++-
>  cls_u32.c     |    2 ++
>  4 files changed, 8 insertions(+), 3 deletions(-)
> 


