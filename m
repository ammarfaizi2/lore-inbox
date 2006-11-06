Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753365AbWKFQ1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbWKFQ1t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378AbWKFQ1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:27:49 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:20142 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1753365AbWKFQ1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:27:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b6dGKEvnD0FEyx5XVDX0dXjhl6ihoZ/9Fik1A+fQKmO9QgWFtW4IzpMEggmSCUbd6dHEWxPblH0Z0sk/HdDyUTQmuqXUbEYA6zVW1PgUyW3S0DOrUVNsjpV8cNaiQP42F27yp8ZBPcDSvSRXVUcDqFkyUDvvi3gqNC7OeqP1ces=
Message-ID: <653402b90611060827t7eaff5acl1a5cbc36c772ba29@mail.gmail.com>
Date: Mon, 6 Nov 2006 16:27:46 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] mm/slab.c: whitespace cleanup
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <84144f020611060818t5890143cn32865750073e602c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061106164727.7ad2fb2c.maxextreme@gmail.com>
	 <84144f020611060818t5890143cn32865750073e602c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On 11/6/06, Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:
> > whitespace cleanup for mm/slab.c
>
> [snip]
>
> > -       addr = (unsigned long *)&((char *)addr)[obj_offset(cachep)];
> > +       addr = (unsigned long *)((char *)addr + obj_offset(cachep));
>
> Call me old-fashioned, but this doesn't count as whitespace cleanup.
> Anyway, why do you want to do this? The coding style changes seem too
> minor to be worth it...
>
>                                Pekka
>

Isn't "p+i" more correct / easy to understand than "&p[i]"?
