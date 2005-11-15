Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVKOAcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVKOAcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVKOAcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:32:41 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:16630 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932214AbVKOAck convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:32:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UEIkYbIlA9nIUIaq3JF8WxF0hufP19sJVQ6qUbcNmjNzsGY/9PQ6BLWmIjGMrHDVH2L7b7ejbM6cHelmOzU1v03j1PjCGYctBY1DVkCtKstq9QRrxxAyEJdPkMC7ehfGMFizDabOiea+c7NsFb4nS/TpdMTHvz6TwFAx54QlaGM=
Message-ID: <625fc13d0511141632k541fe338wb9a51222f4a0f453@mail.gmail.com>
Date: Mon, 14 Nov 2005 18:32:39 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC] HOWTO do Linux kernel development
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <20051114221005.GA5539@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051114220709.GA5234@kroah.com> <20051114221005.GA5539@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/05, Greg KH <gregkh@suse.de> wrote:
> On Mon, Nov 14, 2005 at 02:07:09PM -0800, Greg KH wrote:
> > So, I've been working on a document for the past week or so to help
> > alleviate a lot of these problems.
>
> Oh, the latest version can be found at:
>         http://www.kernel.org/git/?p=linux/kernel/git/gregkh/patches.git;a=blob;f=HOWTO
> as I'm keeping it in my git patch tree.

I don't know if this should go in the <TODO> section of the
development process or somewhere else within "Working with the
community", but I think something along the lines of this might be
helpful:

Leave your ego at home
---------------------------------

The goal of the kernel community is to provide the best possible
kernel there is.  When you submit a patch for acceptance, it will be
reviewed on it's technical merits and those alone.  So, what should
you be expecting?

- criticism,
- comments
- requests for change
- requests justification.

Remember, this is part of getting your patch into the kernel.  You
have to be able to take criticism and comments about your patches,
evaluate them at a technical level and either rework your patches or
provide clear and concise reasoning as to why those changes should not
be made.

What should you not do?

- expect your patch to be accepted without question
- become defensive
- ignore comments and resubmit the patch without making any changes
- explain how your project is funded by XYZ and therefore must be
awesome as it is

In a community that is looking for the best technical solution
possible, there is no place for ego.  You have to be cooperative,
polite, and willing to adapt your idea to fit within the kernel. 
Remember, being wrong is ok as long as you are willing to work toward
a solution that is right.

josh
