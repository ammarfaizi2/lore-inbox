Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWDXWcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWDXWcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWDXWcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:32:06 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:58696 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751336AbWDXWcF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:32:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VSmsn9JgwU5brgZTlxfFsrbu+g4euQcitbNslsvV9rDqAsUdY6Rs3noAnIk7zCUjzwL60gaUBk8Dw/WKBcIfvz59xOs7UIfrP+LJE8Im0f8Ztso11zUqDvU0k79yp2NZrBbdQpONOSvC4jpqIkcFCI00dlipeG+acH+N5JkeVP8=
Message-ID: <bda6d13a0604241532k2179d8c0xf9bee8a3a8a280c8@mail.gmail.com>
Date: Mon, 24 Apr 2006 15:32:04 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
In-Reply-To: <mj+md-20060424.220809.6996.atrey@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	 <1145911546.1635.54.camel@localhost.localdomain>
	 <444D3D32.1010104@argo.co.il>
	 <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>
	 <9f7850090604241450w885fa98v36657ba5f12f071c@mail.gmail.com>
	 <mj+md-20060424.220809.6996.atrey@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/06, Martin Mares <mj@ucw.cz> wrote:
> Hello!
>
> > Oh, and yeah, a = b + c *is* more readable than
> >
> > a = malloc(strlen(b) + strlen(c));
> > strcpy(a,b);
> > strcat(a,c);
> >
> > and contains fewer bugs ;)
>
> Actually, it contains at least the bug you have made in your C example,
> that is forgetting that malloc() can fail. So can string addition, if
> allocated dynamically.
>
>                                 Have a nice fortnight
The C++ code *still* contains fewer bugs. I didn't see the malloc() one, but
there is another.
