Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267557AbTGHTWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTGHTUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:20:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:41385 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S267586AbTGHTTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:19:55 -0400
Date: Tue, 8 Jul 2003 16:31:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] Fix close-to-open in 2.4.22-pre4...
In-Reply-To: <16139.6135.374824.712710@charged.uio.no>
Message-ID: <Pine.LNX.4.55L.0307081630050.21645@freak.distro.conectiva>
References: <16139.6135.374824.712710@charged.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Jul 2003, Trond Myklebust wrote:

>
> Hi Marcelo,
>
>   It's your call whether or not you want to to keep the "Fastwalk"
> patch, however if you do keep it, please could you apply the following
> patch, which restores correct NFS client behaviour w.r.t. data cache
> revalidation under the the open(".")/open("..") operations.

No, I will remove it. Quoting Alan, its indeed "Its too risky".

I'm very happy for getting those feedbacks.
