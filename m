Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWBARMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWBARMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWBARMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:12:37 -0500
Received: from xenotime.net ([66.160.160.81]:31720 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030373AbWBARMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:12:36 -0500
Date: Wed, 1 Feb 2006 09:12:33 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Nigel Cunningham <nigel@suspend2.net>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h'
In-Reply-To: <200602012245.06328.nigel@suspend2.net>
Message-ID: <Pine.LNX.4.58.0602010909530.23607@shark.he.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
 <20060201113711.6320.42205.stgit@localhost.localdomain>
 <84144f020602010432p51ff7a9cq1dd6654bd04f36a4@mail.gmail.com>
 <200602012245.06328.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2006, Nigel Cunningham wrote:

> On Wednesday 01 February 2006 22:32, Pekka Enberg wrote:
> > On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > > Suspend2 uses a strong internal API to separate the method of determining
> > > the content of the image from the method by which it is saved. The code
> > > for determining the content is part of the core of Suspend2, and
> > > transformations (compression and/or encryption) and storage of the pages
> > > are handled by 'modules'.
> >
> > [snip]
> >
> > > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> > >
> > >  0 files changed, 0 insertions(+), 0 deletions(-)
> >
> > Uh, oh, where's the patch?
>
> Indeed! Oops! I think I've managed to put this in kmail without having it mangled!
>
> Nigel
>
>
> [Suspend2] kernel/power/modules.h
>
>  kernel/power/modules.h |  179 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 179 insertions(+), 0 deletions(-)
>
> diff --git a/kernel/power/modules.h b/kernel/power/modules.h
> new file mode 100644
> index 0000000..ee34199
> --- /dev/null
> +++ b/kernel/power/modules.h
> @@ -0,0 +1,179 @@
> +/*
> + * kernel/power/module.h

wrong file name.

> +enum {
> +	FILTER_PLUGIN,
> +	WRITER_PLUGIN,
> +	MISC_PLUGIN, // Block writer, eg.
> +	CHECKSUM_PLUGIN
> +};

Kernel comment style is /* ... */, not // (many places).

> +	/* Bytes! */
Drop the '!'.


-- 
~Randy
