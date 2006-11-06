Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753361AbWKFQSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbWKFQSd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbWKFQSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:18:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:12499 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753361AbWKFQSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:18:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=lXAW44CI1gLqVXFShDn9OVd01z1+NYAtvrSNx1uK7HpiJC9+gFCPJvysnfTvcFCPcliBYvdQju2YoIYVj3+ML2yQjf2mv904IZHb+kLVps/+Ro3sc1AKLVTKwx246CWj1Sg3UYReUK6u+XuCGgAKMwWthK8iDJM9Jo7J9gn+rBc=
Message-ID: <84144f020611060818t5890143cn32865750073e602c@mail.gmail.com>
Date: Mon, 6 Nov 2006 18:18:29 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Miguel Ojeda Sandonis" <maxextreme@gmail.com>
Subject: Re: [PATCH] mm/slab.c: whitespace cleanup
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061106164727.7ad2fb2c.maxextreme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061106164727.7ad2fb2c.maxextreme@gmail.com>
X-Google-Sender-Auth: 16a7224a9f9d4fa3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/06, Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:
> whitespace cleanup for mm/slab.c

[snip]

> -       addr = (unsigned long *)&((char *)addr)[obj_offset(cachep)];
> +       addr = (unsigned long *)((char *)addr + obj_offset(cachep));

Call me old-fashioned, but this doesn't count as whitespace cleanup.
Anyway, why do you want to do this? The coding style changes seem too
minor to be worth it...

                               Pekka
