Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWHAWxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWHAWxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWHAWxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:53:23 -0400
Received: from [81.2.110.250] ([81.2.110.250]:37597 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750718AbWHAWxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:53:23 -0400
Subject: Re: use persistent allocation for cursor blinking.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060801223940.GH22240@redhat.com>
References: <20060801185618.GS22240@redhat.com>
	 <1154470660.15540.92.camel@localhost.localdomain>
	 <20060801223940.GH22240@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Aug 2006 00:12:31 +0100
Message-Id: <1154473951.15540.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-01 am 18:39 -0400, ysgrifennodd Dave Jones:
> On Tue, Aug 01, 2006 at 11:17:40PM +0100, Alan Cox wrote:
> 
>  > If the allocation fails we have allocsize = "somesize" and src = NULL.
>  > The next time we enter the if is false and we fall through and Oops
>  > 
>  > Either check src in the if or set allocsize to something impossible (eg
>  > 0) on the error path.
> 
> Good catch.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>

Acked-by: Alan Cox <alan@redhat.com>

