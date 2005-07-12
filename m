Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVGLLfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVGLLfn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVGLLfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:35:42 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:20163
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S261347AbVGLLfg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:35:36 -0400
Date: Tue, 12 Jul 2005 12:35:33 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ondemand cpufreq ineffective in 2.6.12 ?
In-Reply-To: <6278d22205071204073a6de1a2@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0507121230200.8051@ppg_penguin.kenmoffat.uklinux.net>
References: <6278d22205071204073a6de1a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Daniel J Blueman wrote:

> I find the ondemand governor works as expected with 2.6.12 on my
> Athlon64 Winchester [1]; as soon as I bzip2 a file, processor freq is
> pinned at 1.8GHz and drops to 1GHz when idle.
>

 Thanks, it seems to be a niceness problem - if I run from an xterm as a
user, the processes get a niceness of 10.  If the bzip2 process gets
reniced to 0, all is sweetness.  So, either I have to not use X, or
stick with 2.6.11.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

