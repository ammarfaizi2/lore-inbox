Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbVIAMdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbVIAMdb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 08:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVIAMdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 08:33:31 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:3877 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965097AbVIAMda convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 08:33:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IhVyyq/6+hNa/+aa0YsvICJ2UvRux7ves5UHtrCj2pl7vfe8HaryR8I/KPXCSZbfy40abU4uAPWYkhP08xBiQaf2GyyM6Ib6WATUUpDw8tpnKkh6fK3Z3vLXMrSDyIqo7/U+t4QmOYuPKbu44dCt3O2apsTxDjRuuTtyR5rA2Ko=
Message-ID: <84144f020509010533f5f2440@mail.gmail.com>
Date: Thu, 1 Sep 2005 15:33:24 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: David Teigland <teigland@redhat.com>
Subject: Re: GFS, what's remaining
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
In-Reply-To: <20050901104620.GA22482@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050901104620.GA22482@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/05, David Teigland <teigland@redhat.com> wrote:
> - Adapt the vfs so gfs (and other cfs's) don't need to walk vma lists.
>   [cf. ops_file.c:walk_vm(), gfs works fine as is, but some don't like it.]

It works fine only if you don't care about playing well with other
clustered filesystems.

                                  Pekka
