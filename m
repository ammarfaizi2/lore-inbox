Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWCKL4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWCKL4a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 06:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWCKL43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 06:56:29 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:45875 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751230AbWCKL43 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 06:56:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aRcydnadlwUbSa+LqWF1xuzuOo34cD4SFyDEm1HD7ND7b4OGkvldrsz3xEHtNV5690yVOMpxZ+/C8O3Nn6cAKQlQV0XaalR5WwZk6m0ciaSIOhlRGB5rOUce8sKIkrvZnXmdNpqQxHJDIx7YI1sYGLjz4/yqZkGDKlpJgXZyZbI=
Message-ID: <aec7e5c30603110356w3c866498v5d43c69454bf476e@mail.gmail.com>
Date: Sat, 11 Mar 2006 20:56:28 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [PATCH 00/03] Unmapped: Separate unmapped and mapped pages
Cc: "Magnus Damm" <magnus@valinux.co.jp>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.64.0603101111570.28805@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
	 <Pine.LNX.4.64.0603101111570.28805@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/06, Christoph Lameter <clameter@sgi.com> wrote:
> On Fri, 10 Mar 2006, Magnus Damm wrote:
>
> > Unmapped patches - Use two LRU:s per zone.
>
> Note that if this is done then the default case of zone_reclaim becomes
> trivial to deal with and we can get rid of the zone_reclaim_interval.

That's a good thing, right? =)

> However, I have not looked at the rest yet.

Please do. I'd like to hear what you think about it.

Thanks,

/ magnus
