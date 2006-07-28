Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161108AbWG1JYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbWG1JYA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 05:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWG1JYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 05:24:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161108AbWG1JX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 05:23:59 -0400
Date: Fri, 28 Jul 2006 02:23:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc2-mm1
Message-Id: <20060728022355.2dd1e97a.akpm@osdl.org>
In-Reply-To: <6bffcb0e0607280156s7a6c64eem8849c7d488964b82@mail.gmail.com>
References: <20060727015639.9c89db57.akpm@osdl.org>
	<6bffcb0e0607280156s7a6c64eem8849c7d488964b82@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006 10:56:32 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> On 27/07/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/
> >
> [snip]
> > - Semi-daily snapshots of the -mm lineup are uploaded to
> >   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
> >   the mm-commits list.
> 
> Andrew, have you considered switching that tree to git? IMHO
> git-bisect is a killer-app.
> 

There are many known-to-be-broken bisection points in a -mm tree.  I'd
expect git-style bisection wouldn't be very successful.  quilt-style
bisection is more straightforward.  Plus you can make intelligent decisions
to help it converge faster.
