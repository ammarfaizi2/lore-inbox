Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUBETJI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266552AbUBETJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:09:08 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:60578 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S266526AbUBETGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 14:06:03 -0500
Date: Thu, 5 Feb 2004 20:05:26 +0100
To: Bryan Whitehead <driver@megahappy.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.2] Documentation/SubmittingPatches
Message-ID: <20040205190526.GA25392@mars>
References: <20040205072303.BCF79FA5F1@mrhankey.megahappy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205072303.BCF79FA5F1@mrhankey.megahappy.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 11:23:03PM -0800, Bryan Whitehead wrote:
> 
> I've been trying to get my feet wet by submitting trivial patchs to
> various maintainers and the responses have been, "your not submiting
> you patches correctly". It seems most developers/maintainers want a
> diff done like this:
> 
> cd /source-tree
> diff -u linux-2.6.2/FileToPatch.orig linux-2.6.2/FileToPatch
> 
> instead of the "SubmitingPatches" document way:
> cd /source-tree/linux-2.6.2
> diff -u FileToPatch.orig FileToPatch
> 
> It would be _great_ if the Documentation was more accurate to the taste
> of developers/maintainers...
> 
> If the SubmittingPatches document is correct, then just toss this patch
> out because this won't be submitted right... ;)
> 
> --- linux-2.6.2/Documentation/SubmittingPatches.orig    2004-02-04 22:57:55.818563016 -0800
> +++ linux-2.6.2/Documentation/SubmittingPatches 2004-02-04 23:01:28.799185040 -0800
> @@ -33,13 +33,15 @@
>
>  To create a patch for a single file, it is often sufficient to do:
>
> -       SRCTREE= /devel/linux-2.4
> +       SRCTREE= /devel/
> +       SRCDIR= linux-2.4
>         MYFILE=  drivers/net/mydriver.c

Might as well change this to `linux-2.6' altogether.

	Arthur
