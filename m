Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVGKPrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVGKPrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVGKPol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:44:41 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:65015 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261992AbVGKPoH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:44:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SJ4mrE3icxaUXo3/6IeBWwA10bLJGmhaKOLacOX3r6gIMcyaLSjMfCv+UeIgpQcZWZ9HYcx3BZDR88vOyy25sqmyvVI54vo5A5DR0i3Z//R7J+fdz5/1ba5+uDiK/VTuDaBvRilvFv1F8pVH07fdkcccEW+W1MPud/1AKxkDxJ8=
Message-ID: <d120d50005071108442866ffcd@mail.gmail.com>
Date: Mon, 11 Jul 2005 10:44:06 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: kernel guide to space
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050711145616.GA22936@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050711145616.GA22936@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/11/05, Michael S. Tsirkin <mst@mellanox.co.il> wrote:

> 3e. sizeof
>        space after the operator
>        sizeof a

If braces are used no spaces please : sizeof(struct foo) 
 
> 
> 4c. Breaking long lines
>                Descendants are always substantially shorter than the parent
>                and are placed substantially to the right.
>                        Documentation/CodingStyle
> 
>        Descendant must be indented at least to the level of the innermost
>        compound expression in the parent. All descendants at the same level
>        are indented the same.
>        if (foobar(.................................) + barbar * foobar(bar +
>                                                                        foo *
>                                                                        oof)) {
>        }

Ugh, that's as ugly as it can get... Something like below is much
easier to read...

        if (foobar(.................................) +
            barbar * foobar(bar + foo * oof)) {
        }

-- 
Dmitry
