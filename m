Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbVKHS1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbVKHS1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965252AbVKHS1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:27:04 -0500
Received: from xenotime.net ([66.160.160.81]:32216 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965245AbVKHS1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:27:03 -0500
Date: Tue, 8 Nov 2005 10:27:01 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] DocBook: allow to mark structure members private
In-Reply-To: <20051108183511.GA12043@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.58.0511081025420.15288@shark.he.net>
References: <20051108183511.GA12043@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005, Alexey Dobriyan wrote:

> Randy Dunlap wrote:
> > Ahoy.  Excellent.  Compare my personal todo list item:
>
> > 35.for kernel-doc: make some fields :private: so that a description is not
> >     expected for them.
>
> Aha! A kernel-doc hacker! Randy, by any chance, do you have "support for
> nested structs" in your TODO? And if yes, what's the status? I have
> parsing with the following syntax:

Hi,
Nope, haven't seen that one yet.

>  # /**
>  #  * struct my_struct - short description
>  #  * @a: first member
>  #  * @b: second member
> +#  * @c: nested struct
> +#  * @c.p: first member of nested struct
> +#  * @c.q: second member of nested struct
>  #  *
>  #  * Longer description
>  #  */
>  # struct my_struct {
>  #     int a;
>  #     int b;
> +#     struct her_struct {
> +#         char **p;
> +#         short q;
> +#     } c;
>  # };
>
> But properly nested displaying is in pretty much nil state since .. uh
> crap.. summer.

Is this something that used to work?  If so, when?

-- 
~Randy
