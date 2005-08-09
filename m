Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVHIAZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVHIAZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 20:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVHIAZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 20:25:57 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:49345
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S932384AbVHIAZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 20:25:57 -0400
Date: Tue, 9 Aug 2005 01:25:45 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Andrew Haninger <ahaning@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Compiling module-init-tools versions after v3.0
In-Reply-To: <105c793f050808150810784ef3@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0508090120400.21687@ppg_penguin.kenmoffat.uklinux.net>
References: <105c793f050808150810784ef3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Andrew Haninger wrote:

>
> The problem is that compiling module-init-tools versions after 3.0
> seem require docbook-utils (the compile fails on a docbook2man
> operation) to be installed and docbook-utils requires jade which will
> not compile. I found one jade package called jade-1.2.1 (from '98 or
> '99) which will not compile. I tried openjade, but it does not seem to
> work when compiling docbook-tools (I made a symlink from the openjade
> binary to "jade").
>

 per LFS (http://www.linuxfromscratch.org/lfs/) make DOCBOOKTOMAN=""
(or look at BLFS for the gory details of docbook)

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

