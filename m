Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVHDBjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVHDBjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 21:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVHDBgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 21:36:51 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:48064 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261738AbVHDBed convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 21:34:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DU5s2iGOZQab3EGkPyGNhrtOAV9J1+WIfznV1KWKGbpaooq2b90D52t0NUbKwslmb48rG3dkIUsueLbmo2QhNNNmHdw8fo1WXw26+TCNVdNCXnX8C1N5c1QYLzE+onyKnbDh0NIy6AOgU462QmX9ERfZm53BiGcJv+p/n3uHv3k=
Message-ID: <21d7e99705080318347d6b58d5@mail.gmail.com>
Date: Thu, 4 Aug 2005 11:34:27 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] remove support for gcc < 3.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050731222606.GL3608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050731222606.GL3608@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/05, Adrian Bunk <bunk@stusta.de> wrote:
> This patch removes support for gcc < 3.2 .
> 
> The advantages are:
> - reducing the number of supported gcc versions from 8 to 4 [1]
>   allows the removal of several #ifdef's and workarounds
> - my impression is that the older compilers are only rarely
>   used, so miscompilations of a driver with an old gcc might
>   not be detected for a longer amount of time
> 
>

Another disadvantage is you'll really piss of the VAX developers (all
3 of us!!!, well me not so much anymore...)

I think there is a gcc 4.x compiler nearly capable of building a
kernel for the VAX...

Dave.
