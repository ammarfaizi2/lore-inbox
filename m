Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWHWK4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWHWK4A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWHWKz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:55:59 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:64204 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964856AbWHWKz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:55:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jzC37HYvp0yIXKd5usrkYAYGZSykLeI71yU1aDEfvz5lwtNhI9/J2Nwkd9DYsy3h22fJ6CtdV5X2U1cymfGCGfi/6bpaqO0BgTFjDA05F01PYsTVfYcpoCQu6DhPs1JtBzVolaW5ziDnzdLuwKe8tR3ZrXIamHTKxdYQ6j1IZuk=
Message-ID: <2c0942db0608230355s74af2717g78675ea56b689fc0@mail.gmail.com>
Date: Wed, 23 Aug 2006 03:55:56 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Robert Szentmihalyi" <robert.szentmihalyi@gmx.de>
Subject: Re: Group limit for NFS exported file systems
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060823091652.235230@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060823091652.235230@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/06, Robert Szentmihalyi <robert.szentmihalyi@gmx.de> wrote:
> is there a group limit for NFS exported file systems in recent kernels?
> One if my users cannot access directories that belong to a group he actually _is_ a
> member of. That, however, is true only when accessing them over NFS. On the local file
> system, everything is fine. UIDs and GIDs are the same on client and server, so that
> cannot be the problem. Client and server run Gentoo Linux with kernel 2.6.16 on the
> server and 2.6.17 on the client.

Is he a member of more than 16 groups?
