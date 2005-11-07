Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVKGOqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVKGOqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 09:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKGOqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 09:46:22 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:7076 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750796AbVKGOqV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 09:46:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kBVIlQbTpx3zvNaC4KRUk3Bq2h2FlRjXR2mWXYRrDmM520k7ihtRVbINQhszNN745vUEH3K7t71AIt0wqhhEL53ouaDWSvTiDE4vB7GF+wAH6XxIJIIcRKEq377Rkf6e3B278E5l6Myf5BoGZUh5PYAShxzRBjXrslZL1h/0jLw=
Message-ID: <7e77d27c0511070646o7b8686aes@mail.gmail.com>
Date: Mon, 7 Nov 2005 22:46:20 +0800
From: Yan Zheng <yzcorp@gmail.com>
To: Yan Zheng <yanzheng@21cn.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, David Stevens <dlstevens@us.ibm.com>
Subject: Re: [PATCH][MCAST]Clear MAF_GSQUERY flag when process MLDv1 general query messages.
In-Reply-To: <20051107142517.GA13797@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436F610E.8010400@21cn.com> <20051107142517.GA13797@tuxdriver.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you be more specific about what problem it will cause?
>
> Thanks,
>
> John
> --
> John W. Linville
> linville@tuxdriver.com


If the first query message receive after expiration is MLDv2 general
query and MAF_GSQUERY flag is set. The report message only contains
sources marked by last MLDv2 Multicast Address and Source Specific
Queries . Although this circumstance happens  rare, I think it's
better have it fixed


Regards
