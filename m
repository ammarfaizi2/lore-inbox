Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265149AbUEMT7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUEMT7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUEMT67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:58:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:12251 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265130AbUEMT6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:58:19 -0400
Date: Thu, 13 May 2004 12:57:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: eric.valette@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2 : Hitting Num Lock kills keyboard
Message-Id: <20040513125750.59434a33.akpm@osdl.org>
In-Reply-To: <40A3CF97.5000405@free.fr>
References: <40A3C951.9000501@free.fr>
	<40A3CF97.5000405@free.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette <eric.valette@free.fr> wrote:
>
> Eric Valette wrote:
> > Andrew,
> > 
> > I tested 2.6.6-mm2 this afternoon and twice I totally lost my keyboard. 
> 
> Well, I can reproduce it at will : I just need to hit the numlock key 
> and keyboard is frozen.

Could you please do

	patch -p1 -R -i bk-input.patch

and see if it fixes it?

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm2/broken-out/bk-input.patch
