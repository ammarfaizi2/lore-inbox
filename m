Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161722AbWKFJDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161722AbWKFJDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 04:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161723AbWKFJDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 04:03:18 -0500
Received: from nz-out-0102.google.com ([64.233.162.192]:58346 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161722AbWKFJDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 04:03:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ch8YLGHOSsXX6TM3JxIMWpSZOVayzwI8Hs8TiL1z8qGCbPLH+5m9sn3wHvxUpMrFJ1o4GCN+zRO4Y/mSLXJA/Zkmfg8hDl/YXbzBGQVjWPMUPgp9eHEVvywZQQ1vkyyPgVEC75bf7aOTPYK1kfKjHNvRzYTs1rjohow1bYU6Wpg=
Message-ID: <f55850a70611060103o1415d6f2x81d6c724320a4c04@mail.gmail.com>
Date: Mon, 6 Nov 2006 17:03:15 +0800
From: "Zhao Xiaoming" <xiaoming.nj@gmail.com>
To: "Eric Dumazet" <dada1@cosmosbay.com>
Subject: Re: ZONE_NORMAL memory exhausted by 4000 TCP sockets
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <200611060948.43918.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com>
	 <454EE580.5040506@cosmosbay.com>
	 <f55850a70611060010q3ce9d6d2h4026259d688c6db1@mail.gmail.com>
	 <200611060948.43918.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/11/6, Eric Dumazet <dada1@cosmosbay.com>:
>
> Slab:           293952 kB
> So 292 MB used by slab for 2000 sessions.
>
> Expect 600 MB used by slab for 4000 sessions.
>
> So your precious LOWMEM is not gone at all. It *IS* used by SLAB.
>
> You forgot to send
> cat /proc/slabinfo
>
sorry I didn't make myself clear enough. 2000 sessions means 4000
sockets, 2000 for the server, 2000 for the client.
