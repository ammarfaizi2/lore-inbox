Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUD3Iyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUD3Iyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 04:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUD3Iyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 04:54:41 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:58504 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id S261426AbUD3Iyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 04:54:38 -0400
Message-ID: <1083315269.409214456f48d@www.imp.polymtl.ca>
Date: Fri, 30 Apr 2004 10:54:29 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@polymtl.ca>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
References: <Pine.SGI.4.53.0404261656230.591647@subway.americas.sgi.com>
In-Reply-To: <Pine.SGI.4.53.0404261656230.591647@subway.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 192.90.72.1
X-Poly-FromMTA: (c4.si.polymtl.ca [132.207.4.29]) at Fri, 30 Apr 2004 08:54:29 +0000
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.25.0.2; VDF 6.25.0.39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon Erik Jacobson <erikj@subway.americas.sgi.com>:

> What is Process Aggregates (PAGG)?
> ----------------------------------
> PAGG provides for the implementation of arbitrary process groups in Linux.
> It is a building block for kernel modules that can group processes
> together into a single set for specific purposes beyond the traditional
> process groups.

Hello,

    I'm working on a project (ELSA -Enhanced Linux System Accounting) that is
very similar to PAGG and CSA. My goal is to improve accounting on Linux by using
containers to group processes according to the system administrator policy.
Currently I provide a patch to 2.6.5 kernel ( http://elsa.sourceforge.net ) that
provides infrastructures to manipulate containers. The advantage of my patch is
that manipulating containers is very simple. I think that it could be very
interesting to share our work to see what could be done. Thus I will take a look
to PAGG implementation and also to the CKRM solution proposed by Chris Wright. 

Best,
Guillaume
