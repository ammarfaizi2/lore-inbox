Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVI3ER0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVI3ER0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 00:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVI3ER0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 00:17:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9405 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751430AbVI3ERZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 00:17:25 -0400
Date: Thu, 29 Sep 2005 21:16:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hendrik Visage <hvjunk@gmail.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ion Badulescu <ionut@badula.org>
Subject: Re: Starfire (Adaptec) kernel 2.6.13+ panics on AMD64 NFS server
Message-Id: <20050929211649.69eaddee.akpm@osdl.org>
In-Reply-To: <d93f04c70509292036x269df799y7b51c5be9c3356d6@mail.gmail.com>
References: <d93f04c70509292036x269df799y7b51c5be9c3356d6@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hendrik Visage <hvjunk@gmail.com> wrote:
>
>   Traced a panicing kernel to what appears the starfire changes for
>  2.6.13 up to 2.6.14_rc2
> 
>  During a relative heavy NFS read (client a 32bit 2.6.13.1 P2-350) with
>  rsync (ripped CD archive) I get kernel panics (Aieee interupt handler
>  lost or something... okay also need
>  a way to capture those errors as it's a hard panic and needs a reset button :()

A serial console is useful.  Often people will take a digital photo of the
screen, which works OK.  But we do need that info somehow, please.

>  I've isolated the problem going from 2.6.12.5/2.6.12-gentoo-r10 (both
>  working) to
>  2.6.13/2.6.13-gentoo/2.6.14_rc2 while the NFS is served through the
>  Adaptec/starfire,
>  and further more the onboard forceth(nvidia) is serving the data
>  without hassles (at least
>  on 2.6.14_rc2)

The starfire changes in 2.6.12->2.6.13 look fairly innocuous.  Need that
trace, please.
