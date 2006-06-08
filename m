Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWFHNyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWFHNyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 09:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWFHNyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 09:54:40 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:36138 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964845AbWFHNyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 09:54:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QyyZYf2sADsrBh6pqECop4+6FfZNgQVVX12W44UHInsajEh8FvVST6lI2LQviRv0/n7MoeUAe8lzjDX0aSk7pYtxx4ACZg1+y6hVIeRqSE9t1NN+DOjtxIe1JG7oiS+DvZNN3nhYuE6MvAF8wQiKbIAvrZqEl/wwAInp4eIf9zk=
Message-ID: <a4e6962a0606080654n3157350bgedee4b545988e1dd@mail.gmail.com>
Date: Thu, 8 Jun 2006 08:54:38 -0500
From: "Eric Van Hensbergen" <ericvh@gmail.com>
To: "Florin Malita" <fmalita@gmail.com>
Subject: Re: [PATCH] 9pfs: missing result check in v9fs_vfs_readlink() and v9fs_vfs_link()
Cc: rminnich@lanl.gov, lucho@ionkov.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <4487B83E.4090009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4487B83E.4090009@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/06, Florin Malita <fmalita@gmail.com> wrote:
> __getname() may fail and return NULL (as pointed out by Coverity 437 &
> 1220).
>
> Signed-off-by: Florin Malita <fmalita@gmail.com>
Acked-by: Eric Van Hensbergen <ericvh@gmail.com>
